import 'package:flutter/material.dart';

import '../../model/chat_model.dart';
import '../views/chat/view/indvidual_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.list});
  final ChatModel list;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualGroup(
                chatModel: list,
              ),
            ));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 30,
        child: Icon(
          list.isGroup == false ? Icons.person : Icons.groups_2,
          color: Colors.white,
        ),
      ),
      title: Text(list.name.toString()),
      subtitle: Row(
        children: [
          const Icon(
            Icons.done_all_rounded,
            size: 17,
            color: Colors.blue,
          ),
          SizedBox(
            width: 3,
          ),
          Text(list.currentMessage.toString())
        ],
      ),
      trailing: Text(list.time.toString()),
    );
  }
}
