import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

class Win95ExplorerTile extends StatefulWidget {
  const Win95ExplorerTile({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  State<Win95ExplorerTile> createState() => _Win95ExplorerTileState();
}

class _Win95ExplorerTileState extends State<Win95ExplorerTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _selected = true),
      onTapUp: (_) => setState(() => _selected = false),
      onTapCancel: () => setState(() => _selected = false),
      behavior: HitTestBehavior.opaque,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: Win95Theme.explorerTileMinHeight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Win95Theme.explorerTilePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon,
              const SizedBox(height: Win95Theme.explorerIconLabelGap),
              SizedBox(
                height: Win95Theme.explorerLabelAreaHeight,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: _selected
                      ? BoxDecoration(
                          border: Border.all(
                            color: Win95Colors.darkShadow,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        )
                      : const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      widget.label,
                      style: Win95Typography.explorerLabel.copyWith(
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
