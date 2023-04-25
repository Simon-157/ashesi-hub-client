import 'package:flutter/material.dart';
import 'package:hub_client/ui/views/home/home_page.dart';
import 'package:hub_client/services/auth/firebase_auth.dart';

class MicrosoftButton extends StatefulWidget {
  const MicrosoftButton({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MicrosoftButtonState createState() => _MicrosoftButtonState();
}

class _MicrosoftButtonState extends State<MicrosoftButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.blueGrey, width: 3),
            ),
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromARGB(255, 207, 216, 220),
          ),
          splashFactory: InkRipple.splashFactory,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await signInWithMicrosoft(context).then((result) {
            print(result);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => HomePage(),
              ),
            );
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("images/microsoft.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Continue with Microsoft',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
