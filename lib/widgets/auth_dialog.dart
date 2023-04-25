/// The AuthDialog class is a widget that displays a dialog for user authentication and registration,
/// with options for email/password and Microsoft sign-in.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/services/auth/firebase_auth.dart';
import 'package:hub_client/widgets/microsoft_signin_button.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({Key? key}) : super(key: key);

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  late TextEditingController textControllerEmail;
  late FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  late TextEditingController textControllerPassword;
  late FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;

  bool _isRegistering = false;
  bool _isLoggingIn = false;

  String loginStatus = "";
  Color loginStringColor = const Color.fromARGB(255, 187, 227, 155);

  String? _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String? _validatePassword(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      } else if (value.length < 6) {
        return 'Length of password should be greater than 6';
      }
    }

    return null;
  }

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerPassword = TextEditingController();
    textControllerEmail.text = "";
    textControllerPassword.text = "";
    textFocusNodeEmail = FocusNode();
    textFocusNodePassword = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF05182D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF05182D),
                  Color(0xFF092A45),
                  Color(0xFF0D2339)
                ],
              ),
            ),
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'ASHESI HUB',
                    style: TextStyle(
                      color: Color.fromARGB(255, 176, 190, 197),
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'Email address',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 176, 190, 197),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: TextField(
                    focusNode: textFocusNodeEmail,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: textControllerEmail,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingEmail = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodeEmail.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 44, 160, 218),
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                      hintText: "Email",
                      fillColor: Colors.white,
                      errorText: _isEditingEmail
                          ? _validateEmail(textControllerEmail.text)
                          : null,
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 176, 190, 197),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: TextField(
                    focusNode: textFocusNodePassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: textControllerPassword,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingPassword = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodePassword.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 66, 87, 97),
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                      hintText: "Password",
                      fillColor: Colors.white,
                      errorText: _isEditingPassword
                          ? _validatePassword(textControllerPassword.text)
                          : null,
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.maxFinite,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blueGrey[800],
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isLoggingIn = true;
                                textFocusNodeEmail.unfocus();
                                textFocusNodePassword.unfocus();
                              });
                              if (_validateEmail(textControllerEmail.text) ==
                                      null &&
                                  _validatePassword(
                                          textControllerPassword.text) ==
                                      null) {
                                await signInWithEmailPassword(
                                  context,
                                  textControllerEmail.text,
                                  textControllerPassword.text,
                                ).then((result) {
                                  print(result);
                                  setState(() {
                                    loginStatus = 'logged in';
                                    loginStringColor = Colors.green;
                                    context.go('/?loginstatus=$loginStatus');
                                    context.pop(const AuthDialog());
                                  });
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    context.go('/?loginstatus=$loginStatus');
                                  });
                                }).catchError((error) {
                                  print('Login Error: $error');
                                  setState(() {
                                    loginStatus = "Invalid user credentials";
                                    loginStringColor = Colors.red;
                                  });
                                });
                              } else {
                                setState(() {
                                  loginStatus = 'Please enter email & password';
                                  loginStringColor = Colors.red;
                                });
                              }
                              setState(() {
                                _isLoggingIn = false;
                                textControllerEmail.text = '';
                                textControllerPassword.text = '';
                                _isEditingEmail = false;
                                _isEditingPassword = false;
                              });
                            },
                            child: _isLoggingIn
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Log in',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blueGrey[800]),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.blueGrey[900]),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                textFocusNodeEmail.unfocus();
                                textFocusNodePassword.unfocus();
                              });
                              if (_validateEmail(textControllerEmail.text) ==
                                      null &&
                                  _validatePassword(
                                          textControllerPassword.text) ==
                                      null) {
                                setState(() {
                                  _isRegistering = true;
                                });
                                await registerWithEmailPassword(
                                        textControllerEmail.text,
                                        textControllerPassword.text)
                                    .then((result) {
                                  setState(() {
                                    loginStatus =
                                        'You have registered successfully';
                                    loginStringColor = Colors.green;
                                  });
                                  print(result);
                                }).catchError((error) {
                                  print('Registration Error: $error');
                                  setState(() {
                                    loginStatus =
                                        'Error occured while registering';
                                    loginStringColor = Colors.red;
                                  });
                                });
                              } else {
                                setState(() {
                                  loginStatus = 'Please enter email & password';
                                  loginStringColor = Colors.red;
                                });
                              }
                              setState(() {
                                _isRegistering = false;

                                textControllerEmail.text = '';
                                textControllerPassword.text = '';
                                _isEditingEmail = false;
                                _isEditingPassword = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: _isRegistering
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                loginStatus != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: Text(
                            loginStatus,
                            style: TextStyle(
                              color: loginStringColor,
                              fontSize: 14,
                              // letterSpacing: 3,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                  ),
                  child: Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.blueGrey[200],
                  ),
                ),
                const SizedBox(height: 30),
                const Center(child: MicrosoftButton()),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Proceed to enjoy the goodness of the campus social network',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 176, 190, 197),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
