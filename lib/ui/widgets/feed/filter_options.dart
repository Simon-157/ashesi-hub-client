import 'package:flutter/material.dart';

class FilterOptions extends StatefulWidget {
  final List<String> options;

  FilterOptions({this.options});

  @override
  _FilterOptionsState createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  List<String> selectedOptions = [];

  void _handleOptionSelect(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(220, 13, 35, 57),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ], // Set background color

        borderRadius: const BorderRadius.all(
          Radius.circular(5.0), // Set border radius
        ),
      ),
      width: 300, // Set width constraint
      height: 500, // Set height constraint

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Filter options:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0), // Add left padding
              child: ListView.builder(
                itemCount: widget.options.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildCheckboxListTile(widget.options[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckboxListTile(String optionText) {
    return CheckboxListTile(
      title: Text(optionText),
      value: selectedOptions.contains(optionText),
      onChanged: (value) => _handleOptionSelect(optionText),
    );
  }
}
