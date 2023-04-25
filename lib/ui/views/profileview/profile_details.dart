/// This is a Flutter widget that displays a student's profile information fetched from a server using a
/// FutureBuilder.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/services/api_services/user.dart';
import 'package:hub_client/ui/widgets/profile/change_profile_image_dialog.dart';


class MyStudentWidget extends StatelessWidget {
  final String profileId;

  const MyStudentWidget({Key? key, required this.profileId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(

      future: UserService.getStudent(profileId),
      
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          final student = snapshot.data!;
          print(student);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: student['avatar_url'].isEmpty
                          ? CircleAvatar(
                              radius: 40.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: Center(
                                child: Text(
                                  student['first_name'].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: CachedNetworkImageProvider(
                                    student['avatar_url'],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CameraDialog(
                                              currentAvatarUri:
                                                  student['avatar_url'],
                                              profileId: profileId);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Visibility(
                                visible: false,
                                child: SizedBox(width: 10.0),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      '${student['first_name']}, ${student['year_group'] ?? ""}',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w900,
                                          color: Color.fromARGB(
                                              255, 183, 240, 239)),
                                      maxLines: null,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 130.0,
                                    child: Text(
                                      student['major'],
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 183, 240, 239)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        student['email_or_phone'],
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(198, 20, 191, 203),
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // : buildLikeButton()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
