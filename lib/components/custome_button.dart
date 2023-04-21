import 'package:flutter/material.dart';

/// The function returns a styled button with text and an onTap function.
actionButton(
    {String? text, Function()? function, required BuildContext context}) {
  return Center(
      child: GestureDetector(
    onTap: function,
    child: Container(
      height: 40.0,
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).colorScheme.secondary,
            const Color(0xff597FDB),
          ],
        ),
      ),
      child: Center(
        child: Text(
          text!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  ));
}

actionCount(String label, int count) {
  return Column(
    children: <Widget>[
      Text(
        count.toString(),
        style: const TextStyle(
          color: Colors.green,
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'Ubuntu-Regular',
        ),
      ),
      const SizedBox(height: 3.0),
      Text(
        label,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontFamily: 'Ubuntu-Regular',
        ),
      )
    ],
  );
}
