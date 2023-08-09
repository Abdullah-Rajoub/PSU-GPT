import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool isDarkMood = false;
  void changeAppMode() {
    this.isDarkMood = !this.isDarkMood;
    notifyListeners();
  }
}
