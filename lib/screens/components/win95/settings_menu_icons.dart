import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:flutter/material.dart';

class SettingsMenuIcons {
  const SettingsMenuIcons._();

  static const _assetBase = 'lib/screens/components/win95/icons';

  static Widget appearance() => _icon('$_assetBase/appearance.png');

  static Widget permissions() => _icon('$_assetBase/permissions.png');

  static Widget favorites() => _icon('$_assetBase/favorites.png');

  static Widget preferredApps() => _icon('$_assetBase/preferred_apps.png');

  static Widget restrictedApps() => _icon('$_assetBase/restricted.png');

  static Widget _icon(String asset) {
    return Image.asset(
      asset,
      width: Win95Theme.explorerIconSize,
      height: Win95Theme.explorerIconSize,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.none,
    );
  }
}
