import 'package:flutter/material.dart';
import 'package:hub_client/components/custom_text_field.dart';
import 'package:hub_client/models/students.dart';
import 'package:hub_client/services/api_services/register_api_service.dart';
import 'package:hub_client/utils/authentication.dart';

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
        children: [buildForm(context)],
      ),
    );
  }

  buildForm(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                  prefix: Icons.person_outline,
                  hintText: "first name",
                  controller: firstNameController),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                  prefix: Icons.person_outline,
                  hintText: "last name",
                  controller: lastNameController),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                prefix: Icons.email_outlined,
                hintText: "Email",
                controller: emailController,
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                prefix: Icons.email_outlined,
                hintText: "Student ID",
                controller: studentIdController,
              ),
            ),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                prefix: Icons.account_balance_outlined,
                hintText: "Residence",
                controller: residenceController,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                prefix: Icons.golf_course_outlined,
                hintText: "Major",
                controller: majorController,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                prefix: Icons.class_outlined,
                hintText: "Year Group",
                controller: yeargroupController,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                controller: dateOfBirthController,
                mouseCursor: MaterialStateMouseCursor.clickable,
                onTap: () async {
                  selectedDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ))!;
                  if (selectedDate != null) {}
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.class_outlined),
                  hintText: 'Date of Birth',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                  prefix: Icons.movie_outlined,
                  hintText: "Best Movie",
                  controller: movieController),
            ),
            Container(
              width: 400, // set the desired width here
              child: CustomTextField(
                  prefix: Icons.movie_outlined,
                  hintText: "Favorite Food",
                  controller: foodController),
            ),
            const SizedBox(height: 10.0),
            _buildElevatedButton(context, selectedDate),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context, DateTime selectedDate) {
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
            print(firstNameController?.text);

            Map<String, dynamic> formData = {
              'user_id': uid,
              'first_name': firstNameController?.text,
              'last_name': lastNameController?.text,
              'email_or_phone': emailController?.text,
              'major': majorController?.text,
              'year_group': yeargroupController?.text,
              'student_id': int.parse(studentIdController!.text),
              'avatar_url':
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQDDpg-HtJ5hNVcPj3QDk6q0xmOmQYrdP9jw',
              'best_food': foodController?.text,
              // 'date_of_birth': selectedDate,
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
