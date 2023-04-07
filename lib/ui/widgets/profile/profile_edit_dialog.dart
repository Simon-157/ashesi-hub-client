import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({Key key}) : super(key: key);

  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController yearGroupController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    emailController.dispose();
    dobController.dispose();
    yearGroupController.dispose();
    roomNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: studentIdController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: yearGroupController,
              decoration: const InputDecoration(labelText: 'Year Group'),
            ),
            TextField(
              controller: roomNumberController,
              decoration: const InputDecoration(labelText: 'Room Number'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement update profile functionality here.
            // Display a flash notification
            show_Custom_Flushbar(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void show_Custom_Flushbar(BuildContext context) {
    Flushbar(
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      backgroundGradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 30, 233, 88),
          Color.fromARGB(255, 98, 240, 188),
          Color.fromARGB(220, 27, 50, 37)
        ],
        stops: const [0.4, 0.7, 1],
      ),
      boxShadows: const [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'ashHUb Profile',
      message: 'Profile updated successfully!',
    ).show(context);
  }
}
