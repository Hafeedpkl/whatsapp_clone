import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.contact});
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey[200],
                radius: 23,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                bottom: 4,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 11,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: sqrt1_2,
          ),
          Text(
            contact.name.toString(),
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
