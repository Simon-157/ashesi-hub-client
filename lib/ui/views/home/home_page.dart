import 'package:flutter/material.dart';
import 'package:hub_client/widgets/top_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final Shader iphoneShader =
      const LinearGradient(colors: [Color(0xff070D14), Color(0xff85D1EE)])
          .createShader(const Rect.fromLTWH(0, 100, 50, 2));

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFF05182D),
              Color(0xFF092A45),
              Color(0xFF0D2339)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
            child: Column(
              children: [
                TopBarContents(),
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        const Text('Campus Social Sphere',
                            style: TextStyle(
                                color: Color(0xFFE6949B), fontSize: 18)),
                        const SizedBox(height: 10),
                        Text(
                          'ASHESI HUB',
                          style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = iphoneShader,
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
                        const SizedBox(height: 20),
                        const SizedBox(
                          width: 450,
                          child: Text(
                            'Diversity meets excellence, Share your story inspire others🚀 Connect with like-minded individuals and create a better tomorrow ,              <<< Join the conversation, join the movement >>>',
                            style: TextStyle(
                                color: Color(0xFF4481A6), fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF21A3E2)),
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.explore,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Explore',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Image.asset(
                      'images/social.png',
                      width: 600,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
