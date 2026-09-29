import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';

/// User-configurable launcher appearance settings.
class AppearancePreferences {
  const AppearancePreferences({
    required this.themeColorArgb,
    required this.textColor,
    required this.showTileSeparators,
    required this.appFont,
  });

  /// ARGB color value for the launcher background theme color.
  final int themeColorArgb;

  final LauncherTextColor textColor;

  /// Whether 1px separator lines are drawn between app name rows.
  final bool showTileSeparators;

  final LauncherAppFont appFont;

  static const defaultThemeColorArgb = 0xFF1A1A1A;

  static const defaults = AppearancePreferences(
    themeColorArgb: defaultThemeColorArgb,
    textColor: LauncherTextColor.black,
    showTileSeparators: true,
    appFont: LauncherAppFont.system,
  );

  AppearancePreferences copyWith({
    int? themeColorArgb,
    LauncherTextColor? textColor,
    bool? showTileSeparators,
    LauncherAppFont? appFont,
  }) {
    return AppearancePreferences(
      themeColorArgb: themeColorArgb ?? this.themeColorArgb,
      textColor: textColor ?? this.textColor,
      showTileSeparators: showTileSeparators ?? this.showTileSeparators,
      appFont: appFont ?? this.appFont,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppearancePreferences &&
        other.themeColorArgb == themeColorArgb &&
        other.textColor == textColor &&
        other.showTileSeparators == showTileSeparators &&
        other.appFont == appFont;
  }

  @override
  int get hashCode =>
      Object.hash(themeColorArgb, textColor, showTileSeparators, appFont);
}
