import 'package:flutter/material.dart';

class UsersOnline extends StatefulWidget {
  final List<String> options;

  UsersOnline({Key? key, required this.options}) : super(key: key);

  @override
  _UsersOnlineState createState() => _UsersOnlineState();
}

class _UsersOnlineState extends State<UsersOnline> {
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
    return SizedBox(
        width: 300, // Set width constraint
        height: 500,
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(220, 13, 35, 57),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Add this line to set the mainAxisSize to min
              children: [
                const Text(
                  "Active Users",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 94, 237, 189)),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: buildOptionItem("Simon Owusu", "online"),
                ),
                Flexible(
                  child: buildOptionItem("Simon Owusu", "online"),
                ),
                Flexible(
                  child: buildOptionItem("Simon Owusu", "online"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Direct Messages",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 94, 237, 189)),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: buildOptionItem("Simon Owusu", "5mins ago"),
                ),
                Flexible(
                  child: buildOptionItem("Simon Owusu", "10mins ago"),
                ),
                Flexible(
                  child: buildOptionItem("Simon Owusu", "1day ago"),
                ),
              ],
            )));
  }

  Widget buildOptionItem(String optionText, String status) {
    return GestureDetector(
      onTap: () => _handleOptionSelect(optionText),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200],
              child: const Icon(
                  Icons.person), // use an icon to represent the option
            ),
            Text(
              optionText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
