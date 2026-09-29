import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

class Win95TitleBar extends StatelessWidget {
  const Win95TitleBar({
    super.key,
    required this.title,
    this.active = true,
    this.onClose,
  });

  final String title;
  final bool active;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Win95Theme.titleBarHeight,
      color: active ? Win95Colors.titleBarActive : Win95Colors.titleBarInactive,
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Win95Typography.titleBar,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onClose != null)
            _TitleBarButton(
              label: '×',
              onPressed: onClose,
            ),
        ],
      ),
    );
  }
}

class _TitleBarButton extends StatelessWidget {
  const _TitleBarButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Win95Theme.closeButtonSize,
      height: Win95Theme.closeButtonSize,
      child: Material(
        color: Win95Colors.buttonFace,
        child: InkWell(
          onTap: onPressed,
          child: DecoratedBox(
            decoration: Win95Decorations.outset(),
            child: Center(
              child: Text(
                label,
                style: Win95Typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
