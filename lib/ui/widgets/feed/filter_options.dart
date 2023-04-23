import 'package:flutter/material.dart';

// class FilterOptions extends StatefulWidget {
//   final List<String> options;
//   final Set<String> selectedFilters;

//   FilterOptions(
//       {Key? key, required this.options, required this.selectedFilters, required Null Function(dynamic filters) onFilterChanged})
//       : super(key: key);

//   @override
//   _FilterOptionsState createState() => _FilterOptionsState();
// }

// class _FilterOptionsState extends State<FilterOptions> {
//   List<String> selectedOptions = [];
//   String filterText = '';

//   void _handleOptionSelect(String option) {
//     setState(() {
//       if (selectedOptions.contains(option)) {
//         selectedOptions.remove(option);
//       } else {
//         selectedOptions.add(option);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(220, 13, 35, 57),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         borderRadius: const BorderRadius.all(
//           Radius.circular(5.0),
//         ),
//       ),
//       width: 300,
//       height: 500,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search options...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   filterText = value;
//                 });
//               },
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               'Filter options:',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Color.fromARGB(255, 94, 237, 189)),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: ListView.builder(
//                 itemCount: widget.options.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final optionText = widget.options[index];
//                   if (optionText
//                       .toLowerCase()
//                       .contains(filterText.toLowerCase())) {
//                     return buildCheckboxListTile(optionText);
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCheckboxListTile(String optionText) {
//     return CheckboxListTile(
//       tileColor: const Color.fromARGB(255, 219, 239, 239),
//       checkColor: const Color.fromARGB(255, 219, 239, 239),
//       title: Text(
//         optionText,
//         style: const TextStyle(
//           color: Color.fromARGB(255, 219, 239, 239),
//         ),
//       ),
//       value: selectedOptions.contains(optionText),
//       onChanged: (value) => _handleOptionSelect(optionText),
//     );
//   }
// }

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
