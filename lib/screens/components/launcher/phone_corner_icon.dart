import 'package:flutter/material.dart';

class PhoneCornerIcon extends StatelessWidget {
  const PhoneCornerIcon({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.phone,
      color: color,
      size: 24,
    );
  }
}
