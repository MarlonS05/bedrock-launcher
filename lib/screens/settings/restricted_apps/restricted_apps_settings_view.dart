import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_checkbox.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_desktop.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_panel.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_window_frame.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_state.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestrictedAppsSettingsView extends StatelessWidget {
  const RestrictedAppsSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context
              .read<RestrictedAppsSettingsBloc>()
              .add(const RestrictedAppsSettingsEvent.backTapped());
        }
      },
      child: Win95Desktop(
        child: BlocBuilder<RestrictedAppsSettingsBloc,
            RestrictedAppsSettingsState>(
          builder: (context, state) {
            return state.when(
              loading: () => const _RestrictedAppsWindow(
                child: Center(child: CircularProgressIndicator()),
              ),
              loaded: (
                installedApps,
                savedRestrictedPackageNames,
                draftRestrictedPackageNames,
                isSaving,
                actionErrorMessage,
              ) =>
                  _RestrictedAppsWindow(
                installedApps: installedApps,
                restrictedPackageNames: draftRestrictedPackageNames,
                hasUnsavedChanges: state.hasUnsavedChanges,
                isSaving: isSaving,
                errorMessage: actionErrorMessage,
              ),
              closing: (draftRestrictedPackageNames) => _RestrictedAppsWindow(
                restrictedPackageNames: draftRestrictedPackageNames,
                backPressed: true,
              ),
              error: (message) => _RestrictedAppsWindow(
                errorMessage: message,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RestrictedAppsWindow extends StatelessWidget {
  const _RestrictedAppsWindow({
    this.installedApps = const [],
    this.restrictedPackageNames = const {},
    this.errorMessage,
    this.hasUnsavedChanges = false,
    this.isSaving = false,
    this.backPressed = false,
    this.child,
  });

  final List<LauncherApp> installedApps;
  final Set<String> restrictedPackageNames;
  final String? errorMessage;
  final bool hasUnsavedChanges;
  final bool isSaving;
  final bool backPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RestrictedAppsSettingsBloc>();

    return Win95WindowFrame(
      title: 'Restricted Apps',
      fillScreen: true,
      onClose: () => bloc.add(const RestrictedAppsSettingsEvent.backTapped()),
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
                        _DistractingAppsSection(
                          installedApps: installedApps,
                          restrictedPackageNames: restrictedPackageNames,
                          onToggled: (packageName) => bloc.add(
                            RestrictedAppsSettingsEvent.restrictedAppToggled(
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
                                const RestrictedAppsSettingsEvent.saveTapped(),
                              )
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Win95Button(
                      label: '<< back',
                      fullWidth: true,
                      forcedPressed: backPressed,
                      onPressed: () => bloc.add(
                        const RestrictedAppsSettingsEvent.backTapped(),
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

class _DistractingAppsSection extends StatelessWidget {
  const _DistractingAppsSection({
    required this.installedApps,
    required this.restrictedPackageNames,
    required this.onToggled,
  });

  final List<LauncherApp> installedApps;
  final Set<String> restrictedPackageNames;
  final ValueChanged<String> onToggled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Distracting apps', style: Win95Typography.body),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Checked apps require a math problem before launch.',
          style: Win95Typography.body,
        ),
        const SizedBox(height: AppSpacing.xs),
        Win95Panel(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: installedApps.isEmpty
              ? Text('No apps installed.', style: Win95Typography.body)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < installedApps.length; i++) ...[
                      if (i > 0) const SizedBox(height: AppSpacing.sm),
                      Win95Checkbox(
                        label: installedApps[i].displayName,
                        checked: restrictedPackageNames.contains(
                          installedApps[i].packageName,
                        ),
                        onChanged: (_) =>
                            onToggled(installedApps[i].packageName),
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}
