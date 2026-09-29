import 'package:bedrock_launcher/screens/components/win95/win95_title_bar.dart';
import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:flutter/material.dart';

class Win95WindowFrame extends StatelessWidget {
  const Win95WindowFrame({
    super.key,
    required this.title,
    required this.child,
    this.onClose,
    this.active = true,
    this.fillScreen = false,
  });

  final String title;
  final Widget child;
  final VoidCallback? onClose;
  final bool active;
  final bool fillScreen;

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: Win95Decorations.windowOuter(),
      child: Column(
        mainAxisSize: fillScreen ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Win95TitleBar(
            title: title,
            active: active,
            onClose: onClose,
          ),
          if (fillScreen)
            Expanded(
              child: ColoredBox(
                color: Win95Colors.windowFace,
                child: child,
              ),
            )
          else
            Flexible(
              child: ColoredBox(
                color: Win95Colors.windowFace,
                child: child,
              ),
            ),
        ],
      ),
    );

    if (fillScreen) {
      return SizedBox.expand(child: content);
    }

    final maxWidth =
        MediaQuery.sizeOf(context).width * Win95Theme.windowMaxWidthFraction;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: 280,
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: content,
    );
  }
}
