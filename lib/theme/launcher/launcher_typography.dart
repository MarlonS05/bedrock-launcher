import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_colors.dart';
import 'package:flutter/material.dart';

abstract final class LauncherTypography {
  static const appNameSize = 18.0;

  static const appName = TextStyle(
    fontSize: appNameSize,
    fontWeight: FontWeight.w400,
    color: LauncherColors.appName,
    height: 1.3,
  );

  static TextStyle appNameFor(
    LauncherAppFont font, {
    Color? color,
  }) {
    final base = appName.copyWith(color: color);
    if (font.isSystem) {
      return base;
    }
    return base.copyWith(fontFamily: font.familyId);
  }
}
