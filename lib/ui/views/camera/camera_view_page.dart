import 'dart:io';

import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.title,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 27,
              )),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Container(
            height: size.height - 150,
            width: double.infinity,
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black38,
              width: size.width,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: TextFormField(
                maxLines: 6,
                minLines: 1,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Add Caption...",
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    suffixIcon: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.tealAccent[700],
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
