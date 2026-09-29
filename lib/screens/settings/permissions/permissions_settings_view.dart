import 'package:bedrock_launcher/screens/components/win95/win95_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_desktop.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_panel.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_window_frame.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_state.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsSettingsView extends StatelessWidget {
  const PermissionsSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context
              .read<PermissionsSettingsBloc>()
              .add(const PermissionsSettingsEvent.backTapped());
        }
      },
      child: Win95Desktop(
        child: BlocBuilder<PermissionsSettingsBloc, PermissionsSettingsState>(
          builder: (context, state) {
            return state.when(
              loaded: (isOpening, actionErrorMessage) => _PermissionsWindow(
                isOpening: isOpening,
                errorMessage: actionErrorMessage,
              ),
              closing: () => const _PermissionsWindow(backPressed: true),
              error: (message) => _PermissionsWindow(errorMessage: message),
            );
          },
        ),
      ),
    );
  }
}

class _PermissionsWindow extends StatelessWidget {
  const _PermissionsWindow({
    this.errorMessage,
    this.isOpening = false,
    this.backPressed = false,
  });

  final String? errorMessage;
  final bool isOpening;
  final bool backPressed;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PermissionsSettingsBloc>();

    return Win95WindowFrame(
      title: 'Permissions',
      fillScreen: true,
      onClose: () => bloc.add(const PermissionsSettingsEvent.backTapped()),
      child: Padding(
        padding: const EdgeInsets.all(Win95Theme.windowPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Win95Panel(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Choose bedrockLauncher as your default home app.',
                        style: Win95Typography.body,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Win95Button(
                        label: 'Open home app settings',
                        fullWidth: true,
                        enabled: !isOpening,
                        onPressed: isOpening
                            ? null
                            : () => bloc.add(
                                  const PermissionsSettingsEvent
                                      .openDefaultLauncherTapped(),
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
            ),
            const SizedBox(height: AppSpacing.sm),
            Win95Button(
              label: '<< back',
              fullWidth: true,
              forcedPressed: backPressed,
              onPressed: () =>
                  bloc.add(const PermissionsSettingsEvent.backTapped()),
            ),
          ],
        ),
      ),
    );
  }
}
