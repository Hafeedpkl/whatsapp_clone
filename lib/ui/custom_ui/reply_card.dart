import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: size.width - 45),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // color: const Color(0xffdcf8c6),
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 30,
                      top: 5,
                      bottom: 20,
                    ),
                    child: Text(
                      "Hey",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 0,
                    child: Text(
                      '12:00',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
