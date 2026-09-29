import 'package:bedrock_launcher/screens/components/win95/win95_dotted_border.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

class Win95Button extends StatefulWidget {
  const Win95Button({
    super.key,
    required this.label,
    this.onPressed,
    this.enabled = true,
    this.forcedPressed = false,
    this.minWidth = 96,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool forcedPressed;
  final double minWidth;
  final bool fullWidth;

  @override
  State<Win95Button> createState() => _Win95ButtonState();
}

class _Win95ButtonState extends State<Win95Button> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled && widget.onPressed != null;
    final showPressed = enabled && (widget.forcedPressed || _pressed);
    final decoration = !enabled
        ? const BoxDecoration(color: Win95Colors.buttonFace)
        : Win95Decorations.outset();

    final button = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: Win95Theme.minTouchTarget,
        minWidth: widget.fullWidth ? 0 : widget.minWidth,
      ),
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Center(
            child: Win95DottedBorder(
              visible: showPressed,
              child: Text(
                widget.label,
                style: Win95Typography.body.copyWith(
                  color: enabled ? Win95Colors.text : Win95Colors.shadow,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final sizedButton = widget.fullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled
          ? (_) {
              widget.onPressed?.call();
              if (!widget.forcedPressed) {
                setState(() => _pressed = false);
              }
            }
          : null,
      onTapCancel: enabled && !widget.forcedPressed
          ? () => setState(() => _pressed = false)
          : null,
      child: sizedButton,
    );
  }
}
