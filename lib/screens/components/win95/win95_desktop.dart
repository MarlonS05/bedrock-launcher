import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:flutter/material.dart';

class Win95Desktop extends StatelessWidget {
  const Win95Desktop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Win95Colors.desktop,
      child: child,
    );
  }
}
