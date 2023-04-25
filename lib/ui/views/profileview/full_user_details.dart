import 'package:flutter/material.dart';
import 'package:hub_client/components/custom_widget_attributes.dart';

class ReadOnlyDialog extends StatelessWidget {
  final String title;
  final List<ReadOnlyTextField> fields;

  ReadOnlyDialog({required this.title, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF05182D), Color(0xFF092A45), Color(0xFF0D2339)],
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (ReadOnlyTextField field in fields)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        field.label,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(207, 106, 219, 244)),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        readOnly: true,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 192, 236, 222)),
                        controller: TextEditingController(text: field.value),
                        decoration:  InputDecoration(
                          border: border(context),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ReadOnlyTextField {
  final String label;
  final String value;

  ReadOnlyTextField({required this.label, required this.value});
}
