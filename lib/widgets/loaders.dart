import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

/// This function returns a centered circular progress indicator with a fading circle animation.
Center circularProgress(context) {
  return Center(
    child: SpinKitFadingCircle(
      size: 40.0,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}

/// This function returns a container with a linear progress indicator that uses the secondary color
/// scheme of the current context.
Container linearProgress(context) {
  return Container(
    child: LinearProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
    ),
  );
}