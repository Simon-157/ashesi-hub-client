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
