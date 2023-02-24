import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/ui/views/chat/indvidual_page.dart';
import 'package:whatsapp_clone/ui/views/select_contact/select_contact.dart';

import '../../../custom_ui/custom_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> chats = [
    ChatModel(
        name: 'hafeed',
        isGroup: false,
        currentMessage: 'hi',
        icon: 'person.svg',
        time: '4:00'),
    ChatModel(
        name: 'Muhammed',
        isGroup: false,
        currentMessage: 'hello',
        icon: 'person1.svg',
        time: '5:00'),
    ChatModel(
        name: 'bot group',
        isGroup: true,
        currentMessage: 'hi iam bot',
        icon: 'person3.svg',
        time: '6:00'),
    ChatModel(
        name: 'irshad fans',
        isGroup: true,
        currentMessage: 'hi iam good',
        icon: 'person5.svg',
        time: '10:00')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CustomCard(list: chats[index]);
        },
        itemCount: chats.length,
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
