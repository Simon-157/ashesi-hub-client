import 'package:flutter/material.dart';
import 'package:hub_client/app/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hub_client/providers/provider.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAxcXYC0IyTBZ19NgPnHvAFeHHyw5R_mNM",
        authDomain: "simon-election.firebaseapp.com",
        projectId: "simon-election",
        storageBucket: "simon-election.appspot.com",
        messagingSenderId: "982573082905",
        appId: "1:982573082905:web:573b97a0cdf1dc1d82bd88"),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userState),
        ...providers,
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Ashesi Hub',
        routerConfig: router,
      ),
    );
  }
}
