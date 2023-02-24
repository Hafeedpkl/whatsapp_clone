import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: () {},
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 23,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        'Hafeed',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        'flutter Developer',
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
