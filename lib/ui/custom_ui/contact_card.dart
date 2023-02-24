import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[200],
              radius: 23,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            contact.select == true
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
      title: Text(
        contact.name.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        '${contact.status}',
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
