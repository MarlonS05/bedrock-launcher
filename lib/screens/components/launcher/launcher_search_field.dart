import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_typography.dart';
import 'package:flutter/material.dart';

class LauncherSearchField extends StatelessWidget {
  const LauncherSearchField({
    super.key,
    required this.textColor,
    required this.onChanged,
    this.onSubmitted,
    this.trailing,
    this.appFont = LauncherAppFont.system,
    this.hintText = 'Search',
  });

  final Color textColor;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmitted;
  final Widget? trailing;
  final LauncherAppFont appFont;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        LauncherTheme.listPaddingHorizontal,
        AppSpacing.md,
        LauncherTheme.listPaddingHorizontal,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              style: LauncherTypography.appNameFor(appFont, color: textColor),
              cursorColor: textColor,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: LauncherTypography.appNameFor(
                  appFont,
                  color: textColor.withValues(alpha: 0.5),
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: textColor.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.md,
                ),
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted == null ? null : (_) => onSubmitted!(),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
