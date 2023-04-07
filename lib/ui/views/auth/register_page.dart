import 'package:flutter/material.dart';
import 'package:hub_client/ui/widgets/common/menu.dart';
import 'package:hub_client/ui/widgets/register/register_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({key});

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
              horizontal: MediaQuery.of(context).size.width / 7),
          children: [
            const Menu(),
            RegisterBody(),
          ],
        ),
      ),
    );
  }
}