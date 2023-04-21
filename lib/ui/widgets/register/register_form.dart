import 'package:flutter/material.dart';
import 'package:hub_client/models/students.dart';
import 'package:hub_client/services/api_services/register_api_service.dart';
import 'package:hub_client/services/auth/firebase_auth.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 10),
      child: SizedBox(
        width: 500,
        child: _formRegister(context),
      ),
    );
  }

  Widget _formRegister(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTextField('Enter first name', firstNameController),
          _buildTextField('Enter last name', lastNameController),
          _buildTextField('Enter email or Phone number', emailController),
          _buildTextField('Enter your major', majorController),
          _buildTextField('Choose your year group', yeargroupController),
          _buildTextField('Choose your year group', studentIdController),
          _buildPasswordField(),
          _buildElevatedButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, controller) {
    return SizedBox(
      width: 250, // set the desired width here
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color.fromARGB(255, 20, 80, 129),
            labelStyle: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 244, 244, 244),
            ),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 15, 81, 125)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 210, 220, 226)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
        width: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: const Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 16, 82, 137),
              labelStyle: const TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 210, 220, 226)),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 15, 81, 125)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 210, 220, 226)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ));
  }

  Widget _buildElevatedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 25, 160, 119),
              spreadRadius: 10,
              blurRadius: 20,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () async {
            // Create a Map of form data with the values from the TextFields
            print(firstNameController!.text);
            Map<String, dynamic> formData = {
              'user_id': uid,
              'first_name': firstNameController!.text,
              'last_name': lastNameController!.text,
              'email_or_phone': emailController!.text,
              'major': majorController!.text,
              'year_group': yeargroupController!.text,
              'student_id': int.parse(studentIdController!.text),
              'avatar_url': 'https://i.pravatar.cc/300',
              'best_food': 'jollof'
            };

            try {
              // Call the ApiService method to submit the form data
              Map<String, dynamic> success =
                  await ApiService.submitFormData(formData);

              if (success["status"] == "success") {
                // Show a success message or navigate to a success page
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Student registered successfully'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                // Handle error
                print('error');
              }
            } catch (e) {
              print(e.toString());
              // Handle error
            }
          },
          child: const Text('Register'),
        ),
      ),
    );
  }
}
