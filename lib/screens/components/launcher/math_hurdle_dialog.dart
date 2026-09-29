import 'package:bedrock_launcher/domain/math/math_problem.dart';
import 'package:bedrock_launcher/domain/math/math_problem_generator.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Math hurdle shown before launching a restricted app.
///
/// Returns `true` when the user solves the problem or taps Skip (after 3
/// wrong answers). Returns `false` / `null` when dismissed without success.
class MathHurdleDialog extends StatefulWidget {
  const MathHurdleDialog({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    this.generator,
  });

  final Color backgroundColor;
  final Color textColor;
  final MathProblemGenerator? generator;

  static Future<bool?> show({
    required BuildContext context,
    required Color backgroundColor,
    required Color textColor,
    MathProblemGenerator? generator,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (dialogContext) => MathHurdleDialog(
        backgroundColor: backgroundColor,
        textColor: textColor,
        generator: generator,
      ),
    );
  }

  @override
  State<MathHurdleDialog> createState() => _MathHurdleDialogState();
}

class _MathHurdleDialogState extends State<MathHurdleDialog> {
  late final TextEditingController _controller;
  late final MathProblemGenerator _generator;
  late MathProblem _problem;
  var _wrongAttempts = 0;
  String? _errorMessage;

  static const _maxWrongAttemptsBeforeSkip = 3;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _generator = widget.generator ?? MathProblemGenerator();
    _problem = _generator.generate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSkip => _wrongAttempts >= _maxWrongAttemptsBeforeSkip;

  void _onConfirm() {
    if (MathProblem.answersMatch(_controller.text, _problem.expectedAnswer)) {
      Navigator.of(context).pop(true);
      return;
    }

    setState(() {
      _wrongAttempts += 1;
      _errorMessage = 'Incorrect. Try again.';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LauncherTheme.dialogBorderRadius),
        child: ColoredBox(
          color: widget.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Solve to open',
                  style: LauncherTypography.appName.copyWith(
                    color: widget.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _problem.prompt,
                  style: LauncherTypography.appName.copyWith(
                    color: widget.textColor,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z\s]')),
                  ],
                  style: LauncherTypography.appName.copyWith(
                    color: widget.textColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Answer',
                    hintStyle: LauncherTypography.appName.copyWith(
                      color: widget.textColor.withValues(alpha: 0.5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.textColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.textColor),
                    ),
                  ),
                  onSubmitted: (_) => _onConfirm(),
                  autofocus: true,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _errorMessage!,
                    style: LauncherTypography.appName.copyWith(
                      color: widget.textColor.withValues(alpha: 0.85),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                _ActionRow(
                  label: 'Confirm',
                  textColor: widget.textColor,
                  onTap: _onConfirm,
                ),
                if (_canSkip)
                  _ActionRow(
                    label: 'Skip',
                    textColor: widget.textColor,
                    onTap: () => Navigator.of(context).pop(true),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatefulWidget {
  const _ActionRow({
    required this.label,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final Color textColor;
  final VoidCallback onTap;

  @override
  State<_ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<_ActionRow> {
  var _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: LauncherTheme.listItemPaddingVertical,
        ),
        child: Text(
          widget.label,
          style: LauncherTypography.appName.copyWith(
            color: _pressed
                ? widget.textColor.withValues(alpha: 0.7)
                : widget.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
