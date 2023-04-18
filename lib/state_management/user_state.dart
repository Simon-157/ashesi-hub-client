import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  String? uid;
  String? email;
  bool isAuthenticated = false;

  // void setUser(String? uid, String? email) {
  //   this.uid = uid;
  //   this.email = email;
  //   isAuthenticated = true;
  //   notifyListeners();
  // }

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
