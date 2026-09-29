import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_checkbox.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_color_picker.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_desktop.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_dropdown.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_panel.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_radio_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_window_frame.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_state.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_typography.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppearanceSettingsView extends StatelessWidget {
  const AppearanceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context
              .read<AppearanceSettingsBloc>()
              .add(const AppearanceSettingsEvent.backTapped());
        }
      },
      child: Win95Desktop(
        child: BlocBuilder<AppearanceSettingsBloc, AppearanceSettingsState>(
          builder: (context, state) {
            return state.when(
              loading: () => const _AppearanceWindow(
                child: Center(child: CircularProgressIndicator()),
              ),
              loaded:
                  (
                    savedThemeColorArgb,
                    savedTextColor,
                    savedShowTileSeparators,
                    savedAppFont,
                    draftThemeColorArgb,
                    draftTextColor,
                    draftShowTileSeparators,
                    draftAppFont,
                    availableFonts,
                    isSaving,
                    actionErrorMessage,
                  ) =>
                      _AppearanceWindow(
                themeColorArgb: draftThemeColorArgb,
                textColor: draftTextColor,
                showTileSeparators: draftShowTileSeparators,
                appFont: draftAppFont,
                availableFonts: availableFonts,
                hasUnsavedChanges: state.hasUnsavedChanges,
                isSaving: isSaving,
                errorMessage: actionErrorMessage,
              ),
              closing: (
                draftThemeColorArgb,
                draftTextColor,
                draftShowTileSeparators,
                draftAppFont,
              ) =>
                  _AppearanceWindow(
                themeColorArgb: draftThemeColorArgb,
                textColor: draftTextColor,
                showTileSeparators: draftShowTileSeparators,
                appFont: draftAppFont,
                backPressed: true,
              ),
              error: (message) => _AppearanceWindow(
                errorMessage: message,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AppearanceWindow extends StatelessWidget {
  const _AppearanceWindow({
    this.themeColorArgb,
    this.textColor,
    this.showTileSeparators,
    this.appFont,
    this.availableFonts = const [LauncherAppFont.system],
    this.errorMessage,
    this.hasUnsavedChanges = false,
    this.isSaving = false,
    this.backPressed = false,
    this.child,
  });

  final int? themeColorArgb;
  final LauncherTextColor? textColor;
  final bool? showTileSeparators;
  final LauncherAppFont? appFont;
  final List<LauncherAppFont> availableFonts;
  final String? errorMessage;
  final bool hasUnsavedChanges;
  final bool isSaving;
  final bool backPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AppearanceSettingsBloc>();

    return Win95WindowFrame(
      title: 'Appearance',
      fillScreen: true,
      onClose: () => bloc.add(const AppearanceSettingsEvent.backTapped()),
      child: Padding(
        padding: const EdgeInsets.all(Win95Theme.windowPadding),
        child: child ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (themeColorArgb != null && textColor != null) ...[
                          Text('Preview', style: Win95Typography.body),
                          const SizedBox(height: AppSpacing.xs),
                          _AppearancePreview(
                            themeColorArgb: themeColorArgb!,
                            textColor: textColor!,
                            appFont: appFont ?? LauncherAppFont.system,
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        Text('Theme color', style: Win95Typography.body),
                        const SizedBox(height: AppSpacing.xs),
                        Win95Panel(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: themeColorArgb == null
                              ? const SizedBox.shrink()
                              : Win95ColorPicker(
                                  color: Color(themeColorArgb!),
                                  onChanged: (color) => bloc.add(
                                    AppearanceSettingsEvent.themeColorChanged(
                                      color.toARGB32(),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('Text color', style: Win95Typography.body),
                        const SizedBox(height: AppSpacing.xs),
                        Win95Panel(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: textColor == null
                              ? const SizedBox.shrink()
                              : Row(
                                  children: [
                                    Win95RadioButton(
                                      label: 'Black',
                                      selected:
                                          textColor == LauncherTextColor.black,
                                      onTap: () => bloc.add(
                                        const AppearanceSettingsEvent
                                            .textColorChanged(
                                          LauncherTextColor.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.lg),
                                    Win95RadioButton(
                                      label: 'White',
                                      selected:
                                          textColor == LauncherTextColor.white,
                                      onTap: () => bloc.add(
                                        const AppearanceSettingsEvent
                                            .textColorChanged(
                                          LauncherTextColor.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('App font', style: Win95Typography.body),
                        const SizedBox(height: AppSpacing.xs),
                        Win95Panel(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: appFont == null
                              ? const SizedBox.shrink()
                              : Win95Dropdown<LauncherAppFont>(
                                  value: appFont!,
                                  items: availableFonts,
                                  labelBuilder: (font) => font.label,
                                  itemStyleBuilder: (font) =>
                                      LauncherTypography.appNameFor(font),
                                  onChanged: (font) => bloc.add(
                                    AppearanceSettingsEvent.appFontChanged(
                                      font,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('App list', style: Win95Typography.body),
                        const SizedBox(height: AppSpacing.xs),
                        Win95Panel(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: showTileSeparators == null
                              ? const SizedBox.shrink()
                              : Win95Checkbox(
                                  label: 'Show separator lines between apps',
                                  checked: showTileSeparators!,
                                  onChanged: (show) => bloc.add(
                                    AppearanceSettingsEvent.tileSeparatorsChanged(
                                      show,
                                    ),
                                  ),
                                ),
                        ),
                        if (errorMessage != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            errorMessage!,
                            style: Win95Typography.body.copyWith(
                              color: Colors.red.shade900,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Win95Button(
                      label: 'Save',
                      fullWidth: true,
                      enabled: hasUnsavedChanges && !isSaving,
                      onPressed: hasUnsavedChanges && !isSaving
                          ? () => bloc.add(
                                const AppearanceSettingsEvent.saveTapped(),
                              )
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Win95Button(
                      label: '<< back',
                      fullWidth: true,
                      forcedPressed: backPressed,
                      onPressed: () =>
                          bloc.add(const AppearanceSettingsEvent.backTapped()),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}

class _AppearancePreview extends StatelessWidget {
  const _AppearancePreview({
    required this.themeColorArgb,
    required this.textColor,
    required this.appFont,
  });

  final int themeColorArgb;
  final LauncherTextColor textColor;
  final LauncherAppFont appFont;

  @override
  Widget build(BuildContext context) {
    final textColorValue = switch (textColor) {
      LauncherTextColor.black => const Color(0xFF000000),
      LauncherTextColor.white => const Color(0xFFFFFFFF),
    };

    return Win95Panel(
      padding: EdgeInsets.zero,
      child: ColoredBox(
        color: Color(themeColorArgb),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            'Sample App',
            style: LauncherTypography.appNameFor(
              appFont,
              color: textColorValue,
            ),
          ),
        ),
      ),
    );
  }
}
