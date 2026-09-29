import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

/// Win95-styled HSV color picker with hue slider and saturation/value area.
class Win95ColorPicker extends StatefulWidget {
  const Win95ColorPicker({
    super.key,
    required this.color,
    required this.onChanged,
  });

  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  State<Win95ColorPicker> createState() => _Win95ColorPickerState();
}

class _Win95ColorPickerState extends State<Win95ColorPicker> {
  late HSVColor _hsv;

  @override
  void initState() {
    super.initState();
    _hsv = HSVColor.fromColor(widget.color);
  }

  @override
  void didUpdateWidget(covariant Win95ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _hsv = HSVColor.fromColor(widget.color);
    }
  }

  void _updateHue(double hue) {
    final next = _hsv.withHue(hue);
    setState(() => _hsv = next);
    widget.onChanged(next.toColor());
  }

  void _updateSaturationValue(Offset localPosition, Size size) {
    final saturation = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final value = 1 - (localPosition.dy / size.height).clamp(0.0, 1.0);
    final next = _hsv.withSaturation(saturation).withValue(value);
    setState(() => _hsv = next);
    widget.onChanged(next.toColor());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            DecoratedBox(
              decoration: Win95Decorations.inset(),
              child: SizedBox(
                width: 48,
                height: 48,
                child: ColoredBox(color: _hsv.toColor()),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                '#${_hsv.toColor().toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                style: Win95Typography.body,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _SaturationValuePicker(
          hsv: _hsv,
          onChanged: _updateSaturationValue,
        ),
        const SizedBox(height: AppSpacing.sm),
        _HueSlider(
          hue: _hsv.hue,
          onChanged: _updateHue,
        ),
      ],
    );
  }
}

class _SaturationValuePicker extends StatelessWidget {
  const _SaturationValuePicker({
    required this.hsv,
    required this.onChanged,
  });

  final HSVColor hsv;
  final void Function(Offset localPosition, Size size) onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, 120);
        final markerX = hsv.saturation * size.width;
        final markerY = (1 - hsv.value) * size.height;

        return GestureDetector(
          onPanDown: (details) => onChanged(details.localPosition, size),
          onPanUpdate: (details) => onChanged(details.localPosition, size),
          child: DecoratedBox(
            decoration: Win95Decorations.inset(),
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: size,
                    painter: _SaturationValuePainter(hue: hsv.hue),
                  ),
                  Positioned(
                    left: markerX.clamp(0, size.width - 1) - 4,
                    top: markerY.clamp(0, size.height - 1) - 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Win95Colors.highlight,
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SaturationValuePainter extends CustomPainter {
  _SaturationValuePainter({required this.hue});

  final double hue;

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();

    final saturationGradient = LinearGradient(
      colors: [Colors.white, baseColor],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = saturationGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      ),
    );

    final valueGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = valueGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _SaturationValuePainter oldDelegate) {
    return oldDelegate.hue != hue;
  }
}

class _HueSlider extends StatelessWidget {
  const _HueSlider({
    required this.hue,
    required this.onChanged,
  });

  final double hue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 20.0;
        final markerX = (hue / 360) * width;

        return GestureDetector(
          onPanDown: (details) =>
              onChanged((details.localPosition.dx / width).clamp(0, 1) * 360),
          onPanUpdate: (details) =>
              onChanged((details.localPosition.dx / width).clamp(0, 1) * 360),
          child: DecoratedBox(
            decoration: Win95Decorations.inset(),
            child: SizedBox(
              width: width,
              height: height,
              child: CustomPaint(
                painter: const _HueSliderPainter(),
                child: Stack(
                  children: [
                    Positioned(
                      left: markerX.clamp(0, width - 2) - 1,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        color: Win95Colors.darkShadow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HueSliderPainter extends CustomPainter {
  const _HueSliderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const colors = [
      Color(0xFFFF0000),
      Color(0xFFFFFF00),
      Color(0xFF00FF00),
      Color(0xFF00FFFF),
      Color(0xFF0000FF),
      Color(0xFFFF00FF),
      Color(0xFFFF0000),
    ];

    final gradient = LinearGradient(colors: colors);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
