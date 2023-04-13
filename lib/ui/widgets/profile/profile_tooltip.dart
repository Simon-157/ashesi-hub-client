import 'package:flutter/material.dart';

class ProfileTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const ProfileTooltip({Key? key, required this.message, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: child,
    );
  }
}
