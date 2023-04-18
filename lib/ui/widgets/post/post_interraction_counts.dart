import 'package:flutter/material.dart';

buildLikesCount(BuildContext context, int count) {
  return Padding(
    padding: const EdgeInsets.only(left: 1.0),
    child: Text(
      '$count likes',
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
          color: Color.fromARGB(193, 224, 236, 236)),
    ),
  );
}

buildCommentsCount(BuildContext context, int count) {
  return Padding(
    padding: const EdgeInsets.only(top: 0.5),
    child: Text(
      '$count comments',
      style: const TextStyle(
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(193, 224, 236, 236)),
    ),
  );
}
