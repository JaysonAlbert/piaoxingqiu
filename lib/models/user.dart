import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String phone = '';

  void setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }
}
