import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

class Win95Checkbox extends StatelessWidget {
  const Win95Checkbox({
    super.key,
    required this.label,
    required this.checked,
    required this.onChanged,
  });

  final String label;
  final bool checked;
  final ValueChanged<bool> onChanged;

  static const _indicatorSize = 13.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!checked),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: Win95Decorations.inset(fill: Win95Colors.windowFace),
            child: SizedBox(
              width: _indicatorSize,
              height: _indicatorSize,
              child: checked
                  ? const Center(
                      child: Text(
                        '✓',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1,
                          color: Win95Colors.text,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 6),
          Text(label, style: Win95Typography.body),
        ],
      ),
    );
  }
}
