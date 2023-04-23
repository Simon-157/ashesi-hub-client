import 'package:flutter/material.dart';
import 'package:hub_client/ui/widgets/register/register_body.dart';
import 'package:hub_client/widgets/top_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF05182D), Color(0xFF092A45), Color(0xFF0D2339)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10),
          children: [
            const TopBarContents(),
            RegisterBody(),
          ],
        ),
      ),
    );
  }
}
