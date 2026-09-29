import 'package:bedrock_launcher/theme/launcher/launcher_colors.dart';
import 'package:flutter/material.dart';

class LauncherBackground extends StatelessWidget {
  const LauncherBackground({super.key, this.color, this.child});

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color ?? LauncherColors.backgroundFallback,
      child: child,
    );
  }
}
