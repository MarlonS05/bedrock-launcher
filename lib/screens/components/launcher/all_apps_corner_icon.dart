import 'package:flutter/material.dart';

class AllAppsCornerIcon extends StatelessWidget {
  const AllAppsCornerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomPaint(
        painter: _ThreeLineIconPainter(),
        size: Size(24, 24),
      ),
    );
  }
}

class _ThreeLineIconPainter extends CustomPainter {
  const _ThreeLineIconPainter();

  static const _lineWidth = 18.0;
  static const _lineHeight = 2.0;
  static const _gap = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final centerX = size.width / 2;
    final totalHeight = _lineHeight * 3 + _gap * 2;
    var top = (size.height - totalHeight) / 2;

    for (var i = 0; i < 3; i++) {
      final rect = Rect.fromCenter(
        center: Offset(centerX, top + _lineHeight / 2),
        width: _lineWidth,
        height: _lineHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(1)),
        paint,
      );
      top += _lineHeight + _gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
