import 'package:flutter/material.dart';

class MyAssetImage extends StatelessWidget {
  final String image;

  const MyAssetImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$image.png',
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
