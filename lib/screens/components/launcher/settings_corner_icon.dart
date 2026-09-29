import 'package:flutter/material.dart';

class SettingsCornerIcon extends StatelessWidget {
  const SettingsCornerIcon({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _FourDotIconPainter(color: color),
        size: const Size(24, 24),
      ),
    );
  }
}

class _FourDotIconPainter extends CustomPainter {
  const _FourDotIconPainter({required this.color});

  final Color color;

  static const _dotRadius = 3.0;
  static const _gap = 6.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);
    final offset = _gap / 2 + _dotRadius;

    canvas.drawCircle(
      Offset(center.dx - offset, center.dy - offset),
      _dotRadius,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + offset, center.dy - offset),
      _dotRadius,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx - offset, center.dy + offset),
      _dotRadius,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + offset, center.dy + offset),
      _dotRadius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _FourDotIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
