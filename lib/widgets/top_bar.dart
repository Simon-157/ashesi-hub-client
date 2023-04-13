import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/state_preference/user_store.dart';
import 'package:hub_client/utils/authentication.dart';
import 'package:hub_client/widgets/auth_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBarContents extends StatefulWidget {
  const TopBarContents({Key? key}) : super(key: key);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [false,false,false,false,false,false, false,false];
  UserModel? user;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    returnUser().then((value) => setState(() {
          user = value;
        }));
  }

  Future<UserModel?> returnUser() async {
    UserModel? user = await getAuthUser();
    return user;
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
            InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[3] = true : _isHovering[3] = false;
                });
              },
              onTap: user == null
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => const AuthDialog(),
                      );
                    }
                  : null,
              child: user == null
                  ? Text(
                      'sign in',
                      style: TextStyle(
                        color: _isHovering[3] ? Colors.white : Colors.white70,
                      ),
                    )
                  : TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blueGrey[800]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: _isProcessing
                          ? null
                          : () async {
                              setState(() {
                                _isProcessing = true;
                              });
                              await signOut().then((_) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.remove('user_id');
                              });
                            },
                      child: Text('Sign Out'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
