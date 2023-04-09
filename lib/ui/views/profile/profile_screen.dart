import 'package:flutter/material.dart';
import 'package:hub_client/ui/widgets/profile/profile_icons.dart';
import 'package:hub_client/utils/authentication.dart';

import '../../../services/getuser_api_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: ApiService.getStudent(uid),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show progress indicator while data is being fetched
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final student = snapshot.data['data'];
            print(student);
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF05182D),
                    Color(0xFF092A45),
                    Color(0xFF0D2339)
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: AssetImage('images/simon.png'),
                        radius: 40,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ProfileIcons(
                          editProfile: () {
                            // Navigate to edit profile screen
                          },
                        ),
                      ),
                      const Divider(
                        height: 60,
                        color: Colors.grey,
                      ),
                      const Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.grey, letterSpacing: 2, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        student['first_name'],
                        style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Student ID',
                        style: TextStyle(
                            color: Colors.grey, letterSpacing: 2, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        student['student_id'].toString(),
                        style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.grey, letterSpacing: 2, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            student['email_or_phone'],
                            style: TextStyle(
                                color: Colors.amberAccent[200],
                                letterSpacing: 2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Date of Birth',
                        style: TextStyle(
                            color: Colors.grey, letterSpacing: 2, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "20-12-2023",
                        style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Year Group',
                        style: TextStyle(
                            color: Colors.grey, letterSpacing: 2, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        student['year_group'],
                        style: TextStyle(
                            color: Colors.amberAccent[200],
                            letterSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
