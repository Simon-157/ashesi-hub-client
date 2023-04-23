import 'package:flutter/material.dart';
import 'package:hub_client/components/card_custom.dart';
import 'package:hub_client/components/custom_widget_attributes.dart';
import 'package:hub_client/ui/widgets/register/create_profile_handle.dart';
import 'package:hub_client/utils/firebase_collections.dart';
// ignore: depend_on_referenced_packages

class CreateFormWidget extends StatefulWidget {
  final String? email;

  const CreateFormWidget({Key? key, required this.email}) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<CreateFormWidget> {
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _emailController;
  late TextEditingController _studentIdController;
  late TextEditingController _yearGroupController;
  late TextEditingController _bestFoodController;
  late TextEditingController _bestMovieController;
  late TextEditingController _majorController;
  late TextEditingController _residenceController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _fnameController = TextEditingController(text: "");
    _lnameController = TextEditingController(text: "");
    _bestFoodController = TextEditingController(text: "");
    _bestMovieController = TextEditingController(text: "");
    _majorController = TextEditingController(text: "");
    _studentIdController = TextEditingController(text: "");
    _residenceController = TextEditingController(text: "");
    _yearGroupController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        elevated: false,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: 550,
          width: 400,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF05182D), Color.fromARGB(199, 7, 38, 63)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _InputTextField(
                  _fnameController,
                  "first name",
                  const Icon(
                    Icons.perm_identity,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _lnameController,
                  "first name",
                  const Icon(
                    Icons.perm_identity,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _studentIdController,
                  "Student Id",
                  const Icon(
                    Icons.numbers_rounded,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _majorController,
                  "Major",
                  const Icon(
                    Icons.cast_for_education,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _bestFoodController,
                  "Best Food",
                  const Icon(
                    Icons.food_bank,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _bestMovieController,
                  "Best Movie",
                  const Icon(
                    Icons.movie,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _residenceController,
                  "Residence",
                  const Icon(
                    Icons.location_city,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              _InputTextField(
                  _yearGroupController,
                  "Year Group",
                  const Icon(
                    Icons.group,
                    color: Color.fromARGB(238, 95, 225, 225),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size.square(50))),
                onPressed: () async {
                  print(_fnameController.text);
                  Map<String, dynamic> formData = {
                    'user_id': firebaseAuth.currentUser?.uid,
                    'first_name': _fnameController.text,
                    'last_name': _lnameController.text,
                    'email_or_phone': _emailController.text,
                    'major': _majorController.text,
                    'year_group': _yearGroupController.text,
                    'student_id': int.parse(_studentIdController.text),
                    // a dummy avatar/ user will be able to upload a new profile image later
                    'avatar_url':
                        'https://firebasestorage.googleapis.com/v0/b/simon-election.appspot.com/o/posts_images%2Favatar.png?alt=media&token=69795cb3-8ca3-4a80-9cd4-e8f7c9073557',
                    'best_food': _bestFoodController.text,
                    'best_movie': _bestMovieController.text,
                    'residence': _residenceController.text
                  };

                  createProfile(formData, context);
                },
                child: const Text('Upgrade Profile'),
              ),
            ],
          ),
        ));
  }

  Widget _InputTextField(
      TextEditingController fieldController, String label, Icon icon) {
    return TextFormField(
        style: const TextStyle(color: Color(0xff85D1EE)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 200, 239, 234), fontSize: 18),
          prefixIcon: icon,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: border(context),
          enabledBorder: border(context),
          focusedBorder: focusBorder(context),
        ),
        controller: fieldController);
  }
}
