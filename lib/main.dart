import 'package:flutter/material.dart';
import 'package:hub_client/app/router.dart';
import 'package:hub_client/utils/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hub_client/providers/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyApTxXac3Gi9h6UbrImRPjSt6pNJrYmugc",
        authDomain: "ashesi-hub-b528e.firebaseapp.com",
        projectId: "ashesi-hub-b528e",
        storageBucket: "ashesi-hub-b528e.appspot.com",
        messagingSenderId: "153580039671",
        appId: "1:153580039671:web:599ad849001589de6612f2",
        measurementId: "G-0VBY4D0HM3"),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> getUserInfo() async {
    await getUser(); // assuming `getUser()` is defined elsewhere
    setState(() {});
    print(uid); // assuming `uid` is defined elsewhere
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Ashesi Hub',
          routerConfig: router,
        ));
  }
}
