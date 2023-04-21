import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Stream<UserModel?> getAuthUser(BuildContext context,
    StreamController<UserModel?> streamController) async* {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? currentUserId = prefs.getString('current_user_id') ?? "";
  // ignore: use_build_context_synchronously
  final userState = Provider.of<UserState>(context, listen: false);
  print("getAuth----------------------${userState.uid}");

  var userData = usersRef.doc(userState.uid).snapshots();
  await for (var snapshot in userData) {
    var userDataMap = snapshot.data() as Map<String, dynamic>;
    streamController.add(UserModel.fromJson(
        userDataMap)); // Add the user data to the stream controller
    yield UserModel.fromJson(userDataMap);
  }
}

Future<bool> destroyUserPreference() async {
  bool status = true;
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user_id').then((value) => status = value);
  return status;
}

