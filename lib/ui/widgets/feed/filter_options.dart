/// The `FilterOptions` class is a stateful widget that displays a list of checkbox options and allows
/// the user to select multiple options, triggering a callback function with the selected options.
import 'package:flutter/material.dart';

class FilterOptions extends StatefulWidget {
  final List<String> options;
  final List<String> selectedFilters;
  final Function(List<String>) onFilterChanged;

  FilterOptions({
    required this.options,
    required this.selectedFilters,
    required this.onFilterChanged,
  });

  @override
  _FilterOptionsState createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  List<String> _selectedFilters = [];

  @override
  void initState() {
    super.initState();
    _selectedFilters = widget.selectedFilters;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map(
            (option) => CheckboxListTile(
              title: Text(
                option,
                style:
                    const TextStyle(color: Color.fromARGB(255, 190, 231, 227)),
              ),
              value: _selectedFilters.contains(option),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedFilters.add(option);
                  } else {
                    _selectedFilters.remove(option);
                  }
                  widget.onFilterChanged(_selectedFilters);
                });
              },
            ),
          )
          .toList(),
    );
  }
}
