import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:flutter/material.dart';

abstract final class Win95Typography {
  static const String fontFamily = 'Tahoma';
  static const List<String> fontFamilyFallback = ['sans-serif'];
  static const explorerIconScale = 3.2;
  static const explorerLabelScale = 2.2;

  static const TextStyle _base = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    decoration: TextDecoration.none,
    decorationColor: Colors.transparent,
  );

  static const titleBar = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Win95Colors.titleBarText,
    decoration: TextDecoration.none,
    decorationColor: Colors.transparent,
  );

  static const body = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Win95Colors.text,
    decoration: TextDecoration.none,
    decorationColor: Colors.transparent,
  );

  static final explorerLabel = _base.copyWith(
    fontSize: 12 * explorerLabelScale,
    fontWeight: FontWeight.normal,
    color: Win95Colors.text,
  );

  static final statusBar = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Win95Colors.text,
  );
}
