/// The above code defines two functions that return customized border styles for text input fields in the
/// app.

import 'package:flutter/material.dart';

border(BuildContext context) {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(
      color: Color.fromARGB(179, 19, 63, 87),
      width: 0.0,
    ),
  );
}

focusBorder(BuildContext context) {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(
      color: Color.fromARGB(250, 27, 116, 167),
      width: 1.0,
    ),
  );
}
