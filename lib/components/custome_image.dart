/// The CustomImage class is a Flutter widget that displays a cached network image with customizable
/// height, width, and fit, and an error icon if the image fails to load.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;

  CustomImage({
    required this.imageUrl,
    this.height = 100.0,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
            height: height,
            fit: fit,
            width: width,
          )
        : Container(
            height: 50,
          );
  }
}
