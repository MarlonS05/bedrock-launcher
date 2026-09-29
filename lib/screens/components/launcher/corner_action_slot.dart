import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:flutter/material.dart';

enum CornerAlignment { topLeft, topRight, bottomLeft, bottomRight }

class CornerActionSlot extends StatelessWidget {
  const CornerActionSlot({
    super.key,
    required this.alignment,
    this.stackIndex = 0,
    this.onTap,
    this.onLongPress,
    this.child,
  });

  final CornerAlignment alignment;
  final int stackIndex;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final stackOffset = stackIndex * LauncherTheme.cornerSlotSize;

    return Positioned(
      top: _isTop ? LauncherTheme.cornerInset + stackOffset : null,
      bottom: _isBottom ? LauncherTheme.cornerInset + stackOffset : null,
      left: _isLeft ? LauncherTheme.cornerInset : null,
      right: _isRight ? LauncherTheme.cornerInset : null,
      width: LauncherTheme.cornerSlotSize,
      height: LauncherTheme.cornerSlotSize,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        behavior: HitTestBehavior.opaque,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }

  bool get _isTop =>
      alignment == CornerAlignment.topLeft ||
      alignment == CornerAlignment.topRight;

  bool get _isBottom =>
      alignment == CornerAlignment.bottomLeft ||
      alignment == CornerAlignment.bottomRight;

  bool get _isLeft =>
      alignment == CornerAlignment.topLeft ||
      alignment == CornerAlignment.bottomLeft;

  bool get _isRight =>
      alignment == CornerAlignment.topRight ||
      alignment == CornerAlignment.bottomRight;
}
