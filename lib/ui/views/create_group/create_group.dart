import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/ui/custom_ui/avatar_card.dart';
import 'package:whatsapp_clone/ui/custom_ui/button_card.dart';
import 'package:whatsapp_clone/ui/custom_ui/contact_card.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "hafeed", status: 'flutter developer'),
    ChatModel(name: "muhammed", status: 'flutter developer'),
    ChatModel(name: "john", status: 'node js developer'),
    ChatModel(name: "Rohan", status: 'python developer'),
  ];
  List<ChatModel> groupMember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'New Group',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            Text(
              'Add participants',
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groupMember.length > 0 ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  if (contacts[index - 1].select == false) {
                    setState(() {
                      contacts[index - 1].select = true;
                      groupMember.add(contacts[index - 1]);
                    });
                  } else {
                    setState(() {
                      contacts[index - 1].select = false;
                      groupMember.remove(contacts[index - 1]);
                    });
                  }
                },
                child: ContactCard(
                  contact: contacts[index - 1],
                ),
              );
            },
            itemCount: contacts.length + 1,
          ),
          groupMember.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true) {
                            return InkWell(
                              onTap: () {
                                groupMember.remove(contacts[index]);
                                setState(() {
                                  contacts[index].select = false;
                                });
                              },
                              child: AvatarCard(
                                contact: contacts[index],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Divider()
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
