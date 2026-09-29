import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:flutter/material.dart';

class Win95ExplorerViewport extends StatelessWidget {
  const Win95ExplorerViewport({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Win95Colors.explorerViewport,
        border: Border(
          top: const BorderSide(color: Win95Colors.shadow, width: 2),
          left: const BorderSide(color: Win95Colors.shadow, width: 2),
          bottom: const BorderSide(color: Win95Colors.highlight, width: 2),
          right: const BorderSide(color: Win95Colors.highlight, width: 2),
        ),
      ),
      child: child,
    );
  }
}
