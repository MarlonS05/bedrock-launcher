import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:flutter/material.dart';

abstract final class Win95Decorations {
  static BoxDecoration outset({
    Color fill = Win95Colors.buttonFace,
  }) {
    return BoxDecoration(
      color: fill,
      border: Border(
        top: const BorderSide(color: Win95Colors.highlight, width: 2),
        left: const BorderSide(color: Win95Colors.highlight, width: 2),
        bottom: const BorderSide(color: Win95Colors.shadow, width: 2),
        right: const BorderSide(color: Win95Colors.shadow, width: 2),
      ),
    );
  }

  static BoxDecoration pressed({
    Color fill = Win95Colors.buttonFace,
  }) {
    return BoxDecoration(
      color: fill,
      border: Border(
        top: const BorderSide(color: Win95Colors.shadow, width: 2),
        left: const BorderSide(color: Win95Colors.shadow, width: 2),
        bottom: const BorderSide(color: Win95Colors.highlight, width: 2),
        right: const BorderSide(color: Win95Colors.highlight, width: 2),
      ),
    );
  }

  static BoxDecoration inset({
    Color fill = Win95Colors.windowFace,
  }) {
    return BoxDecoration(
      color: fill,
      border: Border(
        top: const BorderSide(color: Win95Colors.shadow, width: 2),
        left: const BorderSide(color: Win95Colors.shadow, width: 2),
        bottom: const BorderSide(color: Win95Colors.highlight, width: 2),
        right: const BorderSide(color: Win95Colors.highlight, width: 2),
      ),
    );
  }

  static BoxDecoration windowOuter() {
    return BoxDecoration(
      border: Border.all(color: Win95Colors.darkShadow, width: 1),
    );
  }
}
