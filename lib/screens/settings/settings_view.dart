import 'package:bedrock_launcher/screens/components/win95/settings_menu_icons.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_desktop.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_explorer_tile.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_explorer_viewport.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_window_frame.dart';
import 'package:bedrock_launcher/screens/settings/settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/settings_event.dart';
import 'package:bedrock_launcher/screens/settings/settings_state.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const _menuItems = [
    _SettingsMenuItem(
      label: 'Appearance',
      event: SettingsEvent.appearanceTapped(),
      iconBuilder: SettingsMenuIcons.appearance,
    ),
    _SettingsMenuItem(
      label: 'Permissions',
      event: SettingsEvent.permissionsTapped(),
      iconBuilder: SettingsMenuIcons.permissions,
    ),
    _SettingsMenuItem(
      label: 'Favorites',
      event: SettingsEvent.favoritesTapped(),
      iconBuilder: SettingsMenuIcons.favorites,
    ),
    _SettingsMenuItem(
      label: 'Preferred Apps',
      event: SettingsEvent.preferredAppsTapped(),
      iconBuilder: SettingsMenuIcons.preferredApps,
    ),
    _SettingsMenuItem(
      label: 'Restricted Apps',
      event: SettingsEvent.restrictedAppsTapped(),
      iconBuilder: SettingsMenuIcons.restrictedApps,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.read<SettingsBloc>().add(const SettingsEvent.backTapped());
        }
      },
      child: Win95Desktop(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return state.when(
              loaded: () => _SettingsWindow(
                menuItems: _menuItems,
              ),
              closing: () => _SettingsWindow(
                menuItems: _menuItems,
                closePressed: true,
              ),
              error: (message) => _SettingsWindow(
                menuItems: _menuItems,
                errorMessage: message,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SettingsWindow extends StatelessWidget {
  const _SettingsWindow({
    required this.menuItems,
    this.errorMessage,
    this.closePressed = false,
  });

  final List<_SettingsMenuItem> menuItems;
  final String? errorMessage;
  final bool closePressed;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();

    return Win95WindowFrame(
      title: 'Settings',
      fillScreen: true,
      onClose: () => bloc.add(const SettingsEvent.backTapped()),
      child: Padding(
        padding: const EdgeInsets.all(Win95Theme.windowPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Win95ExplorerViewport(
                child: GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: Win95Theme.explorerTileMinHeight,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return Win95ExplorerTile(
                      label: item.label,
                      icon: item.iconBuilder(),
                      onTap: () => bloc.add(item.event),
                    );
                  },
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
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: Win95Button(
                label: 'close',
                forcedPressed: closePressed,
                onPressed: () => bloc.add(const SettingsEvent.backTapped()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsMenuItem {
  const _SettingsMenuItem({
    required this.label,
    required this.event,
    required this.iconBuilder,
  });

  final String label;
  final SettingsEvent event;
  final Widget Function() iconBuilder;
}
