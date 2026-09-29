import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_desktop.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_dropdown.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_panel.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_window_frame.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_state.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sentinel value for "System default" in [Win95Dropdown] items.
const _systemDefaultPackage = '';

class PreferredAppsSettingsView extends StatelessWidget {
  const PreferredAppsSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context
              .read<PreferredAppsSettingsBloc>()
              .add(const PreferredAppsSettingsEvent.backTapped());
        }
      },
      child: Win95Desktop(
        child: BlocBuilder<PreferredAppsSettingsBloc, PreferredAppsSettingsState>(
          builder: (context, state) {
            return state.when(
              loading: () => const _PreferredAppsWindow(
                child: Center(child: CircularProgressIndicator()),
              ),
              loaded: (
                installedApps,
                savedClockPackageName,
                savedPhonePackageName,
                savedCameraPackageName,
                savedGalleryPackageName,
                draftClockPackageName,
                draftPhonePackageName,
                draftCameraPackageName,
                draftGalleryPackageName,
                isSaving,
                actionErrorMessage,
              ) =>
                  _PreferredAppsWindow(
                installedApps: installedApps,
                clockPackageName: draftClockPackageName,
                phonePackageName: draftPhonePackageName,
                cameraPackageName: draftCameraPackageName,
                galleryPackageName: draftGalleryPackageName,
                hasUnsavedChanges: state.hasUnsavedChanges,
                isSaving: isSaving,
                errorMessage: actionErrorMessage,
              ),
              closing: (
                draftClockPackageName,
                draftPhonePackageName,
                draftCameraPackageName,
                draftGalleryPackageName,
              ) =>
                  _PreferredAppsWindow(
                clockPackageName: draftClockPackageName,
                phonePackageName: draftPhonePackageName,
                cameraPackageName: draftCameraPackageName,
                galleryPackageName: draftGalleryPackageName,
                backPressed: true,
              ),
              error: (message) => _PreferredAppsWindow(
                errorMessage: message,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PreferredAppsWindow extends StatelessWidget {
  const _PreferredAppsWindow({
    this.installedApps = const [],
    this.clockPackageName,
    this.phonePackageName,
    this.cameraPackageName,
    this.galleryPackageName,
    this.errorMessage,
    this.hasUnsavedChanges = false,
    this.isSaving = false,
    this.backPressed = false,
    this.child,
  });

  final List<LauncherApp> installedApps;
  final String? clockPackageName;
  final String? phonePackageName;
  final String? cameraPackageName;
  final String? galleryPackageName;
  final String? errorMessage;
  final bool hasUnsavedChanges;
  final bool isSaving;
  final bool backPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PreferredAppsSettingsBloc>();

    return Win95WindowFrame(
      title: 'Preferred Apps',
      fillScreen: true,
      onClose: () =>
          bloc.add(const PreferredAppsSettingsEvent.backTapped()),
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
                        _PreferredAppPicker(
                          label: 'Clock',
                          selectedPackageName: clockPackageName,
                          installedApps: installedApps,
                          onChanged: (packageName) => bloc.add(
                            PreferredAppsSettingsEvent.clockAppChanged(
                              packageName,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _PreferredAppPicker(
                          label: 'Phone',
                          selectedPackageName: phonePackageName,
                          installedApps: installedApps,
                          onChanged: (packageName) => bloc.add(
                            PreferredAppsSettingsEvent.phoneAppChanged(
                              packageName,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _PreferredAppPicker(
                          label: 'Camera',
                          selectedPackageName: cameraPackageName,
                          installedApps: installedApps,
                          onChanged: (packageName) => bloc.add(
                            PreferredAppsSettingsEvent.cameraAppChanged(
                              packageName,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _PreferredAppPicker(
                          label: 'Gallery',
                          selectedPackageName: galleryPackageName,
                          installedApps: installedApps,
                          onChanged: (packageName) => bloc.add(
                            PreferredAppsSettingsEvent.galleryAppChanged(
                              packageName,
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
                                const PreferredAppsSettingsEvent.saveTapped(),
                              )
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Win95Button(
                      label: '<< back',
                      fullWidth: true,
                      forcedPressed: backPressed,
                      onPressed: () => bloc.add(
                        const PreferredAppsSettingsEvent.backTapped(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}

class _PreferredAppPicker extends StatelessWidget {
  const _PreferredAppPicker({
    required this.label,
    required this.selectedPackageName,
    required this.installedApps,
    required this.onChanged,
  });

  final String label;
  final String? selectedPackageName;
  final List<LauncherApp> installedApps;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = _dropdownItems(
      installedApps: installedApps,
      selectedPackageName: selectedPackageName,
    );
    final labelsByPackage = <String, String>{
      _systemDefaultPackage: 'System default',
      for (final app in installedApps) app.packageName: app.displayName,
      if (selectedPackageName != null &&
          selectedPackageName!.isNotEmpty &&
          !installedApps.any((app) => app.packageName == selectedPackageName))
        selectedPackageName!: selectedPackageName!,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Win95Typography.body),
        const SizedBox(height: AppSpacing.xs),
        Win95Panel(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Win95Dropdown<String>(
            value: selectedPackageName ?? _systemDefaultPackage,
            items: items,
            labelBuilder: (packageName) =>
                labelsByPackage[packageName] ?? packageName,
            onChanged: (packageName) => onChanged(
              packageName == _systemDefaultPackage ? null : packageName,
            ),
          ),
        ),
      ],
    );
  }

  static List<String> _dropdownItems({
    required List<LauncherApp> installedApps,
    required String? selectedPackageName,
  }) {
    final items = <String>[
      _systemDefaultPackage,
      ...installedApps.map((app) => app.packageName),
    ];
    if (selectedPackageName != null &&
        selectedPackageName.isNotEmpty &&
        !items.contains(selectedPackageName)) {
      items.add(selectedPackageName);
    }
    return items;
  }
}
