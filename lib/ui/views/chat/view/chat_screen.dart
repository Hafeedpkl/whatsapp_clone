import 'package:flutter/material.dart';
import 'package:whatsapp_clone/ui/views/select_contact/select_contact.dart';

import '../../../../model/chat_model.dart';
import '../../../custom_ui/custom_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.chatmodels, required this.sourceChat});
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CustomCard(
            list: widget.chatmodels[index],
            sourcechat: widget.sourceChat,
          );
        },
        itemCount: widget.chatmodels.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Selectcontact(),
              ));
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
