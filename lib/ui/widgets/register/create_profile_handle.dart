import 'package:flutter/material.dart';
import 'package:hub_client/services/api_services/register_api_service.dart';

void createProfile(Map<String, dynamic> formData, BuildContext context) async {
  try {
    // Call the ApiService method to submit the form data
    Map<String, dynamic> success = await ApiService.submitFormData(formData);

    if (success["status"] == "success") {
      // Show a success message or navigate to a success page
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Profile created successfully'),
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
}
