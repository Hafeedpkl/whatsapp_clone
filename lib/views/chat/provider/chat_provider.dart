import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  bool show = false;
  void showChanger() {
    show = !show;
  }
}
