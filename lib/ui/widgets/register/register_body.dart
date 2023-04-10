import 'package:flutter/material.dart';
import 'package:hub_client/ui/widgets/register/regiter_view_form.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);

  final Shader sloganShade =
      const LinearGradient(colors: [Color(0xff070D14), Color(0xff85D1EE)])
          .createShader(const Rect.fromLTWH(0, 100, 50, 2));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // height: MediaQuery.of(context).size.height,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join TO Explore With Friends IN the Community',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = sloganShade,
                        shadows: const [
                          Shadow(
                              offset: Offset(10, 10),
                              blurRadius: 20,
                              color: Colors.black),
                          Shadow(
                              offset: Offset(10, 10),
                              blurRadius: 20,
                              color: Colors.black12),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "If you don't have an account",
                    style: TextStyle(
                        color: Color.fromARGB(255, 146, 180, 201),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "You can",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          print(MediaQuery.of(context).size.width);
                        },
                        child: const Text(
                          "Register here!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 211, 255, 250),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'images/illustration-2.png',
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 50),
              child: Container(
                width: 500,
                child: const Center(child: RegisterForm()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
