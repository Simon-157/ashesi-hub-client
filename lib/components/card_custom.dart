/// The CustomCard class is a customizable card widget in Flutter that can be elevated or not and has a
/// child widget and an onTap function.
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final BorderRadius borderRadius;
  final bool elevated;

  CustomCard({
    Key? key,
    required this.child,
    required this.onTap,
    required this.borderRadius,
    this.elevated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: elevated
          ? BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).cardColor,
            )
          : BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).cardColor,
            ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
