import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/services/firestore_services/profile_services.dart';
import 'package:hub_client/services/auth/firebase_auth.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:hub_client/widgets/auth_dialog.dart';

class TopBarContents extends StatefulWidget {
  const TopBarContents({Key? key}) : super(key: key);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
  ];

  bool userModifiedProfile() {
    if (firebaseAuth.currentUser != null) {
      bool doesExist = false;
      ProfileService.doesDocumentExist(firebaseAuth.currentUser!.uid)
          .then((value) => doesExist = value);
      return doesExist;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo_ashesi.png',
              width: 50,
              height: 50,
            ),
            Text(
              'ashHub',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                letterSpacing: 3,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: screenSize.width / 8),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[0] = true : _isHovering[0] = false;
                      });
                    },
                    onTap: () => {context.go('/feeds')},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Feeds',
                          style: TextStyle(
                            color: _isHovering[0]
                                ? Colors.blue[200]
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[0],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenSize.width / 50,
            ),

            // TODO DYNAMICALLY SHOW LOGIN AND USER AVATAR

            firebaseAuth.currentUser != null
                ? userModifiedProfile()
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20.0),
                          const SizedBox(width: 20.0),
                          Tooltip(
                            message: "View Profile",
                            preferBelow: false,
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: ProfileService.getUserSnapshot(
                                  firebaseAuth.currentUser!.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Icon(Icons.error);
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasData) {
                                  final userDoc = snapshot.data!;
                                  final avatarUrl =
                                      userDoc.get('avatar_url') as String?;

                                  return InkWell(
                                      onTap: () {
                                        context.go(
                                            '/profile/${firebaseAuth.currentUser?.uid}');
                                      },
                                      child: CircleAvatar(
                                        radius: 15.0,
                                        backgroundImage:
                                            NetworkImage(avatarUrl!),
                                      ));
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      context.go(
                                          '/profile/${firebaseAuth.currentUser?.uid}');
                                    },
                                    child: const Text("improve profile"),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 30.0),
                          IconButton(
                            tooltip: "logout",
                            mouseCursor: MaterialStateMouseCursor.clickable,
                            padding: const EdgeInsets.only(right: 5.0),
                            onPressed: () {
                              signOut(context);
                              context.go('/');
                            },
                            icon: const Icon(
                              Icons.logout,
                              size: 30.0,
                              color: Color.fromARGB(255, 213, 243, 239),
                            ),
                          ),
                        ],
                      )
                    : IconButton(
                        tooltip: "upgrade profile",
                        mouseCursor: MaterialStateMouseCursor.clickable,
                        padding: const EdgeInsets.only(right: 5.0),
                        onPressed: () {
                          context.go('/upgrade_profile');
                        },
                        icon: const Icon(
                          Icons.person_off_outlined,
                          size: 30.0,
                          color: Color.fromARGB(255, 198, 230, 221),
                        ),
                      )
                : IconButton(
                    tooltip: "login",
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    padding: const EdgeInsets.only(right: 5.0),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AuthDialog(),
                      );
                    },
                    icon: const Icon(
                      Icons.login,
                      semanticLabel: "Login",
                      size: 30.0,
                      color: Color.fromARGB(255, 213, 243, 239),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
