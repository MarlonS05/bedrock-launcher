import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_typography.dart';
import 'package:flutter/material.dart';

const _launcherPackageName = 'com.example.bedrock_launcher';

class LauncherAppActionDialog extends StatefulWidget {
  const LauncherAppActionDialog({
    super.key,
    required this.displayName,
    required this.packageName,
    required this.isFavorite,
    required this.backgroundColor,
    required this.textColor,
    required this.onFavoriteToggled,
    required this.onUninstall,
    required this.onOpenAppSettings,
  });

  final String displayName;
  final String packageName;
  final bool isFavorite;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onFavoriteToggled;
  final VoidCallback onUninstall;
  final VoidCallback onOpenAppSettings;

  static Future<void> show({
    required BuildContext context,
    required String displayName,
    required String packageName,
    required bool isFavorite,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onFavoriteToggled,
    required VoidCallback onUninstall,
    required VoidCallback onOpenAppSettings,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (dialogContext) => LauncherAppActionDialog(
        displayName: displayName,
        packageName: packageName,
        isFavorite: isFavorite,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onFavoriteToggled: () {
          Navigator.of(dialogContext).pop();
          onFavoriteToggled();
        },
        onUninstall: () {
          Navigator.of(dialogContext).pop();
          onUninstall();
        },
        onOpenAppSettings: () {
          Navigator.of(dialogContext).pop();
          onOpenAppSettings();
        },
      ),
    );
  }

  @override
  State<LauncherAppActionDialog> createState() =>
      _LauncherAppActionDialogState();
}

class _LauncherAppActionDialogState extends State<LauncherAppActionDialog> {
  bool get _canUninstall => widget.packageName != _launcherPackageName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LauncherTheme.dialogBorderRadius),
        child: ColoredBox(
          color: widget.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  widget.displayName,
                  style: LauncherTypography.appName.copyWith(
                    color: widget.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _ActionRow(
                label: widget.isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                textColor: widget.textColor,
                onTap: widget.onFavoriteToggled,
              ),
              if (_canUninstall)
                _ActionRow(
                  label: 'Uninstall',
                  textColor: widget.textColor,
                  onTap: widget.onUninstall,
                ),
              _ActionRow(
                label: 'App settings',
                textColor: widget.textColor,
                onTap: widget.onOpenAppSettings,
              ),
              _ActionRow(
                label: 'Cancel',
                textColor: widget.textColor,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatefulWidget {
  const _ActionRow({
    required this.label,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final Color textColor;
  final VoidCallback onTap;

  @override
  State<_ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<_ActionRow> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: LauncherTheme.listItemPaddingVertical,
        ),
        child: Text(
          widget.label,
          style: LauncherTypography.appName.copyWith(
            color: _pressed
                ? widget.textColor.withValues(alpha: 0.7)
                : widget.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
