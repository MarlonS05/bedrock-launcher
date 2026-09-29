import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Invisible lower-half overlay that detects upward / leftward swipes and
/// double taps.
///
/// Uses [HitTestBehavior.translucent] so taps pass through to widgets below.
class BrowserSwipeZone extends StatefulWidget {
  const BrowserSwipeZone({
    super.key,
    required this.onSwipeUp,
    required this.onSwipeLeft,
    this.onDoubleTap,
    this.heightFraction = LauncherTheme.browserSwipeZoneFraction,
  });

  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeLeft;
  final VoidCallback? onDoubleTap;
  final double heightFraction;

  @override
  State<BrowserSwipeZone> createState() => _BrowserSwipeZoneState();
}

class _BrowserSwipeZoneState extends State<BrowserSwipeZone> {
  Offset? _start;
  var _swipeTriggered = false;
  DateTime? _lastTapUpAt;
  Offset? _lastTapUpPosition;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * widget.heightFraction;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: height,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          _start = event.position;
          _swipeTriggered = false;
        },
        onPointerMove: (event) {
          _maybeTriggerSwipe(event.position);
        },
        onPointerUp: (event) {
          _maybeTriggerSwipe(event.position);
          if (!_swipeTriggered) {
            _maybeTriggerDoubleTap(event.position);
          }
          _resetPointer();
        },
        onPointerCancel: (_) => _resetPointer(),
        child: const SizedBox.expand(),
      ),
    );
  }

  void _maybeTriggerSwipe(Offset position) {
    final start = _start;
    if (start == null || _swipeTriggered) {
      return;
    }

    final deltaY = start.dy - position.dy;
    if (deltaY >= LauncherTheme.browserSwipeMinDistance) {
      _swipeTriggered = true;
      widget.onSwipeUp();
      return;
    }

    final deltaX = start.dx - position.dx;
    if (deltaX >= LauncherTheme.browserSwipeMinDistance) {
      _swipeTriggered = true;
      widget.onSwipeLeft();
    }
  }

  void _maybeTriggerDoubleTap(Offset position) {
    final onDoubleTap = widget.onDoubleTap;
    if (onDoubleTap == null) {
      return;
    }

    final now = DateTime.now();
    final lastAt = _lastTapUpAt;
    final lastPosition = _lastTapUpPosition;
    if (lastAt != null &&
        lastPosition != null &&
        now.difference(lastAt) <= kDoubleTapTimeout &&
        (position - lastPosition).distance <= kDoubleTapSlop) {
      _lastTapUpAt = null;
      _lastTapUpPosition = null;
      onDoubleTap();
      return;
    }

    _lastTapUpAt = now;
    _lastTapUpPosition = position;
  }

  void _resetPointer() {
    _start = null;
    _swipeTriggered = false;
  }
}
