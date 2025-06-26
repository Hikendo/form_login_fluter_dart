import 'package:flutter/material.dart';

class ImagenApp extends StatelessWidget {
  final String imagePath;
  final double height;
  final double? width;
  final BoxFit fit;

  const ImagenApp({
    Key? key,
    required this.imagePath,
    this.height = 150,
    this.width,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, height: height, width: width, fit: fit);
  }
}
