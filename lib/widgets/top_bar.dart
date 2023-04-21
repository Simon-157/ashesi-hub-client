import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/state_preference/user_store.dart';
import 'package:hub_client/utils/authentication.dart';
import 'package:hub_client/widgets/auth_dialog.dart';
import 'package:provider/provider.dart';

class TopBarContents extends StatefulWidget {
  const TopBarContents({Key? key}) : super(key: key);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  // UserModel? user;
  bool _isProcessing = false;
  final StreamController<UserModel?> _userStreamController =
      StreamController<UserModel?>();

  Stream<UserModel?> returnUser() {
    Stream<UserModel?> user = getAuthUser(context, _userStreamController);
    print('user signed in  = ${user.isEmpty}');
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final userState = Provider.of<UserState>(context, listen: false);
    print("provider state ----------- ${userState.uid}");
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
            InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[3] = true : _isHovering[3] = false;
                  });
                },
                child: StreamBuilder<UserModel?>(
                    stream: _userStreamController
                        .stream, // Listen to the stream controller
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        UserModel? user = snapshot.data;
                        // Render the UI with the user's data
                        onTap:
                        user == null
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AuthDialog(),
                                );
                              }
                            : null;
                        return user == null
                            ? Text(
                                'sign in',
                                style: TextStyle(
                                  color: _isHovering[3]
                                      ? Colors.white
                                      : Colors.white70,
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  await signOut(context).then((_) async {
                                    await destroyUserPreference().then((value) {
                                      if (value) {
                                        _userStreamController.add(
                                            null); // Add null to the stream controller to indicate that the user has signed out
                                      }
                                    });
                                  });
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.avatar_url),
                                      radius: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text('Sign Out'),
                                  ],
                                ),
                              );
                      } else if (snapshot.hasError) {
                        // Handle errors
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        // Render a loading spinner while the data is being fetched
                        return InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[3] = true
                                    : _isHovering[3] = false;
                              });
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AuthDialog(),
                              );
                            },
                            child: Text(
                              'sign in',
                              style: TextStyle(
                                color: _isHovering[3]
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ));
                      } else {
                        return Container();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
