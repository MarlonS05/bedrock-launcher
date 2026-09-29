import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

abstract final class Win95Theme {
  static const titleBarHeight = 28.0;
  static const minTouchTarget = 48.0;
  static const windowPadding = AppSpacing.md;
  static const windowMaxWidthFraction = 0.9;
  static const explorerIconSize = 32.0 * Win95Typography.explorerIconScale;
  static const explorerIconLabelGap = 2.0;
  static const explorerTilePadding = AppSpacing.xs;
  static const explorerLabelLineHeight =
      12.0 * Win95Typography.explorerLabelScale;
  static const explorerLabelAreaHeight = explorerLabelLineHeight * 2;
  static const explorerTileMinHeight =
      explorerIconSize + explorerIconLabelGap + explorerLabelAreaHeight +
      explorerTilePadding * 2;
  static const closeButtonSize = 24.0;

  static ThemeData themeData() {
    return ThemeData(
      fontFamily: Win95Typography.fontFamily,
      fontFamilyFallback: Win95Typography.fontFamilyFallback,
      scaffoldBackgroundColor: Win95Colors.desktop,
      useMaterial3: false,
      textTheme: const TextTheme(
        bodyMedium: Win95Typography.body,
        bodyLarge: Win95Typography.body,
        labelLarge: Win95Typography.body,
        titleMedium: Win95Typography.titleBar,
      ).apply(
        decoration: TextDecoration.none,
        decorationColor: Colors.transparent,
      ),
    );
  }
}
