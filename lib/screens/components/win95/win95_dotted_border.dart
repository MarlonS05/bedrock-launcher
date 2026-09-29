import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:flutter/material.dart';

class Win95DottedBorder extends StatelessWidget {
  const Win95DottedBorder({
    super.key,
    required this.child,
    required this.visible,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
  });

  final Widget child;
  final bool visible;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return child;
    }

    return CustomPaint(
      foregroundPainter: const _DottedRectPainter(),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _DottedRectPainter extends CustomPainter {
  const _DottedRectPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Win95Colors.darkShadow
      ..strokeWidth = 1;

    const dash = 1.0;
    const gap = 1.0;

    _drawDottedLine(
      canvas,
      paint,
      Offset(0, 0),
      Offset(size.width, 0),
      dash,
      gap,
    );
    _drawDottedLine(
      canvas,
      paint,
      Offset(size.width, 0),
      Offset(size.width, size.height),
      dash,
      gap,
    );
    _drawDottedLine(
      canvas,
      paint,
      Offset(size.width, size.height),
      Offset(0, size.height),
      dash,
      gap,
    );
    _drawDottedLine(
      canvas,
      paint,
      Offset(0, size.height),
      Offset(0, 0),
      dash,
      gap,
    );
  }

  void _drawDottedLine(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    double dash,
    double gap,
  ) {
    final total = (end - start).distance;
    if (total == 0) {
      return;
    }

    final direction = (end - start) / total;
    var distance = 0.0;
    var draw = true;

    while (distance < total) {
      final segment = draw ? dash : gap;
      final next = distance + segment;
      if (draw) {
        canvas.drawLine(
          start + direction * distance,
          start + direction * next.clamp(0, total),
          paint,
        );
      }
      distance = next;
      draw = !draw;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedRectPainter oldDelegate) => false;
}
