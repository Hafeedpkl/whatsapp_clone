import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whatsapp_clone/ui/custom_ui/contact_card.dart';

class Selectcontact extends StatefulWidget {
  const Selectcontact({super.key});

  @override
  State<Selectcontact> createState() => _SelectcontactState();
}

class _SelectcontactState extends State<Selectcontact> {
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
        itemBuilder: (context, index) => ContactCard(),
        itemCount: 20,
      ),
    );
  }
}
