import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

var uid = null;

Future<String?> registerWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User user = userCredential.user!;

  assert(user.uid != null);
  assert(user.email != null);

  uid = user.uid;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  return 'Successfully registered, User UID: ${user.uid}';
}

Future<String> signOut(BuildContext context) async {
  await _auth.signOut();

  final userState = Provider.of<UserState>(context, listen: false);
  userState.clearUser();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;

  return 'User signed out';
}

Future<String?> signInWithEmailPassword(
    BuildContext context, String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User? user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    // authUser = ApiService.getStudent(uid);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    final userState = Provider.of<UserState>(context, listen: false);
    userState.setUser(currentUser!.uid, user.email!);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', user.email!);
    prefs.setBool('auth', true);
    prefs.setString('current_user_id', currentUser.uid);

    return 'Successfully logged in, User UID: ${user.uid}';
  }

  return null;
}

// MICROSOFT AUTHENTICATION
Future<UserCredential> signInWithMicrosoft(BuildContext context) async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Create a new instance of the Microsoft OAuth provider
  final OAuthProvider microsoftProvider = OAuthProvider('microsoft.com');

  // Set the scopes for the Microsoft OAuth provider
  microsoftProvider.addScope('User.Read');

  // Sign in with Microsoft using the OAuth provider
  final UserCredential authCredential =
      await firebaseAuth.signInWithPopup(microsoftProvider);

  // Return the user credential
  uid = authCredential.user!.uid;

  final userState = Provider.of<UserState>(context, listen: false);
  userState.setUser(authCredential.user!.uid, authCredential.user!.email);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', true);
  prefs.setString('current_user_id', authCredential.user!.uid);
  print("singed in: ------------${authCredential.user!.uid}");
  return await firebaseAuth
      .signInWithCredential(authCredential as AuthCredential);
}
