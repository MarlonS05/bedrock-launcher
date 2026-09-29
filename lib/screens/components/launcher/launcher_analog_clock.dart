import 'dart:async';
import 'dart:math' as math;

import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:flutter/material.dart';

class LauncherAnalogClock extends StatefulWidget {
  const LauncherAnalogClock({
    required this.color,
    required this.size,
    this.batteryLevel,
    this.onResume,
    this.onTap,
    super.key,
  });

  final Color color;
  final double size;
  final int? batteryLevel;
  final VoidCallback? onResume;
  final VoidCallback? onTap;

  @override
  State<LauncherAnalogClock> createState() => _LauncherAnalogClockState();
}

class _LauncherAnalogClockState extends State<LauncherAnalogClock>
    with WidgetsBindingObserver {
  Timer? _minuteTimer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    WidgetsBinding.instance.addObserver(this);
    _minuteTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _minuteTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() => _now = DateTime.now());
      widget.onResume?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final clock = CustomPaint(
      painter: _LauncherAnalogClockPainter(
        color: widget.color,
        batteryLevel: widget.batteryLevel,
        time: _now,
      ),
      size: Size.square(widget.size),
    );

    final onTap = widget.onTap;
    if (onTap == null) {
      return clock;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: clock,
    );
  }
}

class _LauncherAnalogClockPainter extends CustomPainter {
  const _LauncherAnalogClockPainter({
    required this.color,
    required this.time,
    this.batteryLevel,
  });

  final Color color;
  final DateTime time;
  final int? batteryLevel;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final handRadius = size.width / 2;
    final minuteReach =
        handRadius * LauncherTheme.clockHandMinuteReachFraction;
    final ringRadius = minuteReach +
        LauncherTheme.clockHandMinuteWidth / 2 +
        LauncherTheme.clockRingHandGap +
        LauncherTheme.clockRingStrokeWidth / 2;

    _paintBatteryRing(canvas, center, ringRadius);
    _paintHourTicks(canvas, center, handRadius);
    _paintHands(canvas, center, handRadius);
  }

  void _paintBatteryRing(Canvas canvas, Offset center, double radius) {
    final level = batteryLevel;
    if (level == null || level <= 0) {
      return;
    }

    final ringRect = Rect.fromCircle(center: center, radius: radius);
    final sweepRadians = (level / 100) * 2 * math.pi;
    final chargePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = LauncherTheme.clockRingStrokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      ringRect,
      -math.pi / 2,
      sweepRadians,
      false,
      chargePaint,
    );
  }

  void _paintHourTicks(Canvas canvas, Offset center, double radius) {
    const hourCount = 12;

    for (var hour = 0; hour < hourCount; hour++) {
      final isQuarter = hour % 3 == 0;
      final tickPaint = Paint()
        ..color = color.withValues(alpha: LauncherTheme.clockHourTickOpacity)
        ..strokeWidth = isQuarter
            ? LauncherTheme.clockQuarterTickStrokeWidth
            : LauncherTheme.clockHourTickStrokeWidth
        ..strokeCap = StrokeCap.round;

      final innerRadius = radius *
          (isQuarter
              ? LauncherTheme.clockQuarterTickInnerRadiusFraction
              : LauncherTheme.clockHourTickInnerRadiusFraction);
      final outerRadius = radius *
          (isQuarter
              ? LauncherTheme.clockQuarterTickOuterRadiusFraction
              : LauncherTheme.clockHourTickOuterRadiusFraction);

      final angle = (-math.pi / 2) + (hour * 2 * math.pi / hourCount);
      final cos = math.cos(angle);
      final sin = math.sin(angle);
      canvas.drawLine(
        Offset(center.dx + innerRadius * cos, center.dy + innerRadius * sin),
        Offset(center.dx + outerRadius * cos, center.dy + outerRadius * sin),
        tickPaint,
      );
    }
  }

  void _paintHands(Canvas canvas, Offset center, double radius) {
    final minute = time.minute + time.second / 60;
    final hour = (time.hour % 12) + minute / 60;

    final minuteAngle = (minute / 60) * 2 * math.pi - math.pi / 2;
    final hourAngle = (hour / 12) * 2 * math.pi - math.pi / 2;

    final minutePaint = Paint()
      ..color = color
      ..strokeWidth = LauncherTheme.clockHandMinuteWidth
      ..strokeCap = StrokeCap.round;

    final hourPaint = Paint()
      ..color = color
      ..strokeWidth = LauncherTheme.clockHandHourWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      center,
      Offset(
        center.dx +
            radius *
                LauncherTheme.clockHandMinuteReachFraction *
                math.cos(minuteAngle),
        center.dy +
            radius *
                LauncherTheme.clockHandMinuteReachFraction *
                math.sin(minuteAngle),
      ),
      minutePaint,
    );
    canvas.drawLine(
      center,
      Offset(
        center.dx +
            radius *
                LauncherTheme.clockHandHourReachFraction *
                math.cos(hourAngle),
        center.dy +
            radius *
                LauncherTheme.clockHandHourReachFraction *
                math.sin(hourAngle),
      ),
      hourPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LauncherAnalogClockPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.batteryLevel != batteryLevel ||
        oldDelegate.time.minute != time.minute ||
        oldDelegate.time.hour != time.hour;
  }
}
