import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_colors.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_typography.dart';
import 'package:flutter/material.dart';

class LauncherAppList extends StatelessWidget {
  const LauncherAppList({
    super.key,
    required this.apps,
    required this.onAppTap,
    this.onAppLongPress,
    this.textColor,
    this.appFont = LauncherAppFont.system,
    this.showSeparators = true,
    this.scrollable = true,
  });

  final List<LauncherApp> apps;
  final ValueChanged<String> onAppTap;
  final ValueChanged<String>? onAppLongPress;
  final Color? textColor;
  final LauncherAppFont appFont;
  final bool showSeparators;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = textColor ?? LauncherColors.appName;
    final horizontalPadding = const EdgeInsets.symmetric(
      horizontal: LauncherTheme.listPaddingHorizontal,
    );

    if (!scrollable) {
      final children = <Widget>[];
      for (var index = 0; index < apps.length; index++) {
        if (showSeparators && index > 0) {
          children.add(
            ColoredBox(
              color: resolvedTextColor,
              child: const SizedBox(height: LauncherTheme.listSeparatorHeight),
            ),
          );
        }

        final app = apps[index];
        children.add(
          _AppNameRow(
            name: app.displayName,
            textColor: resolvedTextColor,
            appFont: appFont,
            onTap: () => onAppTap(app.packageName),
            onLongPress: onAppLongPress == null
                ? null
                : () => onAppLongPress!(app.packageName),
          ),
        );
      }

      return Padding(
        padding: horizontalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      );
    }

    if (!showSeparators) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: LauncherTheme.listPaddingHorizontal,
        ),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return _AppNameRow(
            name: app.displayName,
            textColor: resolvedTextColor,
            appFont: appFont,
            onTap: () => onAppTap(app.packageName),
            onLongPress: onAppLongPress == null
                ? null
                : () => onAppLongPress!(app.packageName),
          );
        },
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: LauncherTheme.listPaddingHorizontal,
      ),
      itemCount: apps.length,
      separatorBuilder: (_, _) => ColoredBox(
        color: resolvedTextColor,
        child: const SizedBox(height: LauncherTheme.listSeparatorHeight),
      ),
      itemBuilder: (context, index) {
        final app = apps[index];
        return _AppNameRow(
          name: app.displayName,
          textColor: resolvedTextColor,
          appFont: appFont,
          onTap: () => onAppTap(app.packageName),
          onLongPress: onAppLongPress == null
              ? null
              : () => onAppLongPress!(app.packageName),
        );
      },
    );
  }
}

class _AppNameRow extends StatefulWidget {
  const _AppNameRow({
    required this.name,
    required this.onTap,
    required this.textColor,
    required this.appFont,
    this.onLongPress,
  });

  final String name;
  final VoidCallback onTap;
  final Color textColor;
  final LauncherAppFont appFont;
  final VoidCallback? onLongPress;

  @override
  State<_AppNameRow> createState() => _AppNameRowState();
}

class _AppNameRowState extends State<_AppNameRow> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedContainer(
        duration: LauncherTheme.appNamePressDuration,
        curve: Curves.easeInOut,
        color: _pressed
            ? LauncherColors.appNamePressOverlay
            : Colors.transparent,
        child: AnimatedScale(
          scale: _pressed ? LauncherTheme.appNamePressScale : 1,
          duration: LauncherTheme.appNamePressDuration,
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            opacity: _pressed ? LauncherTheme.appNamePressedOpacity : 1,
            duration: LauncherTheme.appNamePressDuration,
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: LauncherTheme.listItemPaddingVertical,
              ),
              child: Text(
                widget.name,
                style: LauncherTypography.appNameFor(
                  widget.appFont,
                  color: widget.textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
