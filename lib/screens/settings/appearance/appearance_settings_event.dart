import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appearance_settings_event.freezed.dart';

@freezed
sealed class AppearanceSettingsEvent with _$AppearanceSettingsEvent {
  const factory AppearanceSettingsEvent.started() = _Started;

  const factory AppearanceSettingsEvent.backTapped() = _BackTapped;

  const factory AppearanceSettingsEvent.saveTapped() = _SaveTapped;

  const factory AppearanceSettingsEvent.themeColorChanged(int colorArgb) =
      _ThemeColorChanged;

  const factory AppearanceSettingsEvent.textColorChanged(
    LauncherTextColor textColor,
  ) = _TextColorChanged;

  const factory AppearanceSettingsEvent.tileSeparatorsChanged(bool show) =
      _TileSeparatorsChanged;

  const factory AppearanceSettingsEvent.appFontChanged(
    LauncherAppFont appFont,
  ) = _AppFontChanged;
}
