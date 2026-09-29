import 'package:flutter/material.dart';

class CameraCornerIcon extends StatelessWidget {
  const CameraCornerIcon({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _CameraIconPainter(color: color),
        size: const Size(24, 24),
      ),
    );
  }
}

class _CameraIconPainter extends CustomPainter {
  const _CameraIconPainter({required this.color});

  final Color color;

  static const _strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.28,
        size.width * 0.84,
        size.height * 0.56,
      ),
      const Radius.circular(2),
    );
    canvas.drawRRect(body, paint);

    final viewfinder = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.34,
        size.height * 0.12,
        size.width * 0.32,
        size.height * 0.18,
      ),
      const Radius.circular(1),
    );
    canvas.drawRRect(viewfinder, paint);

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.56),
      size.width * 0.16,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CameraIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
