import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/ui/views/calls/call_screen.dart';
import 'package:whatsapp_clone/ui/views/camera/view/camera_screen.dart';
import 'package:whatsapp_clone/ui/views/chat/view/chat_screen.dart';
import 'package:whatsapp_clone/ui/views/status/status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.chatModel, required this.sourceChat});
  final List<ChatModel> chatModel;
  final ChatModel sourceChat;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF075E54),
          title: const Text('WhatsApp'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: 1,
                    child: Text('New Group'),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('New broadCast'),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text('whatsapp Web'),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Text('Starred Messages'),
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: Text('Settings'),
                  )
                ];
              },
              onSelected: (value) => print(value),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: controller,
            tabs: const [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                child: Text('CHATS'),
              ),
              Tab(
                child: Text('STATUS'),
              ),
              Tab(
                child: Text('CALLS'),
              )
            ],
          ),
        ),
        body: TabBarView(controller: controller, children: [
          const CameraScreen(),
          ChatScreen(
              chatmodels: widget.chatModel, sourceChat: widget.sourceChat),
          const StatusScreen(),
          const CallScreen()
        ]));
  }
}
