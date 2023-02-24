import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/ui/custom_ui/button_card.dart';
import 'package:whatsapp_clone/ui/custom_ui/contact_card.dart';

import '../create_group/create_group.dart';

class Selectcontact extends StatefulWidget {
  const Selectcontact({super.key});

  @override
  State<Selectcontact> createState() => _SelectcontactState();
}

class _SelectcontactState extends State<Selectcontact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: "hafeed", status: 'flutter developer'),
      ChatModel(name: "muhammed", status: 'flutter developer'),
      ChatModel(name: "john", status: 'node js developer'),
      ChatModel(name: "Rohan", status: 'python developer'),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Select Contact',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            Text(
              '36 contacts',
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 1,
                  child: Text('Invite a friend'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Contacts'),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text('Refresh'),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Text('Help'),
                ),
              ];
            },
            onSelected: (value) => print(value),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateGroup(),
                    ));
              },
              child: ButtonCard(
                icon: Icons.group,
                name: 'New Group',
              ),
            );
          } else if (index == 1) {
            return ButtonCard(
              icon: Icons.person_add,
              name: 'New Contact',
            );
          }
          return ContactCard(
            contact: contacts[index - 2],
          );
        },
        itemCount: contacts.length + 2,
      ),
    );
  }
}
