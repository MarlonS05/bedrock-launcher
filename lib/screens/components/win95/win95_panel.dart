import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

class Win95Panel extends StatelessWidget {
  const Win95Panel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: Win95Decorations.inset(fill: Win95Colors.windowFace),
      child: Padding(
        padding: padding,
      child: DefaultTextStyle(
        style: Win95Typography.body,
        child: child,
      ),
      ),
    );
  }
}
