import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  String? uid;
  String? email;
  bool isAuthenticated = false;

  void setUser(String? id, String? u_email) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      uid = id;
      email = u_email;
      notifyListeners();
    });
  }

  void clearUser() {
    uid = null;
    email = null;
    isAuthenticated = false;
    notifyListeners();
  }
}
