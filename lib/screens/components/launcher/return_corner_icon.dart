import 'package:flutter/material.dart';

class ReturnCornerIcon extends StatelessWidget {
  const ReturnCornerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomPaint(
        painter: _ReturnArrowPainter(),
        size: Size(24, 24),
      ),
    );
  }
}

class _ReturnArrowPainter extends CustomPainter {
  const _ReturnArrowPainter();

  static const _strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final centerY = size.height / 2;
    final left = size.width * 0.2;
    final right = size.width * 0.8;
    final midX = size.width * 0.35;

    canvas.drawLine(Offset(right, centerY), Offset(left, centerY), paint);
    canvas.drawLine(Offset(left, centerY), Offset(midX, centerY - 6), paint);
    canvas.drawLine(Offset(left, centerY), Offset(midX, centerY + 6), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
