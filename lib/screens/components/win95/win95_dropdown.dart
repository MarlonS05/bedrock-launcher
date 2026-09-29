import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_decorations.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';

class Win95Dropdown<T> extends StatefulWidget {
  const Win95Dropdown({
    super.key,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.itemStyleBuilder,
  });

  final T value;
  final List<T> items;
  final String Function(T item) labelBuilder;
  final ValueChanged<T> onChanged;
  final TextStyle Function(T item)? itemStyleBuilder;

  @override
  State<Win95Dropdown<T>> createState() => _Win95DropdownState<T>();
}

class _Win95DropdownState<T> extends State<Win95Dropdown<T>> {
  final _anchorKey = GlobalKey();

  Future<void> _openMenu() async {
    final renderBox =
        _anchorKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }

    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final anchorTopLeft = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );
    final anchorBottomRight = renderBox.localToGlobal(
      renderBox.size.bottomRight(Offset.zero),
      ancestor: overlay,
    );
    final position = RelativeRect.fromRect(
      Rect.fromPoints(anchorTopLeft, anchorBottomRight),
      Offset.zero & overlay.size,
    );

    final selected = await showMenu<T>(
      context: context,
      position: position,
      color: Win95Colors.windowFace,
      shape: const RoundedRectangleBorder(),
      items: [
        for (final item in widget.items)
          PopupMenuItem<T>(
            value: item,
            height: Win95Theme.minTouchTarget,
            child: Text(
              widget.labelBuilder(item),
              style: widget.itemStyleBuilder?.call(item) ??
                  Win95Typography.body,
            ),
          ),
      ],
    );

    if (selected != null && selected != widget.value) {
      widget.onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedStyle =
        widget.itemStyleBuilder?.call(widget.value) ?? Win95Typography.body;

    return Row(
      key: _anchorKey,
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: Win95Decorations.inset(fill: Win95Colors.windowFace),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                widget.labelBuilder(widget.value),
                style: selectedStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        GestureDetector(
          onTap: _openMenu,
          child: DecoratedBox(
            decoration: Win95Decorations.outset(),
            child: SizedBox(
              width: Win95Theme.minTouchTarget,
              height: Win95Theme.minTouchTarget,
              child: const Center(
                child: Text('▼', style: Win95Typography.body),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
