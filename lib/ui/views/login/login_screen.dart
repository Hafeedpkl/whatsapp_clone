import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whatsapp_clone/ui/custom_ui/button_card.dart';
import 'package:whatsapp_clone/ui/views/home/home_screen.dart';

import '../../../model/chat_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
        name: 'hafeed',
        isGroup: false,
        currentMessage: 'hi',
        icon: 'person.svg',
        time: '4:00',
        id: 1),
    ChatModel(
        name: 'Muhammed',
        isGroup: false,
        currentMessage: 'hello',
        icon: 'person1.svg',
        time: '5:00',
        id: 2),
    ChatModel(
        name: 'bot',
        isGroup: false,
        currentMessage: 'hi iam bot',
        icon: 'person3.svg',
        time: '6:00',
        id: 3),
    ChatModel(
        name: 'irshad',
        isGroup: false,
        currentMessage: 'hi iam good',
        icon: 'person5.svg',
        time: '10:00',
        id: 5)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              chatmodels.removeAt(index);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(chatModel: chatmodels),
                  ));
            },
            child:
                ButtonCard(name: chatmodels[index].name!, icon: Icons.person)),
        itemCount: chatmodels.length,
      ),
    );
  }
}
