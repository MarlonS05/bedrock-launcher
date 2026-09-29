import 'package:bedrock_launcher/domain/math/math_operation.dart';
import 'package:bedrock_launcher/domain/math/round_half_up.dart';

/// A generated math problem shown before launching a restricted app.
class MathProblem {
  const MathProblem({
    required this.operation,
    required this.left,
    required this.right,
    required this.expectedAnswer,
  });

  final MathOperation operation;
  final int left;
  final int right;

  /// Expected answer already rounded half-up to 2 decimal places.
  final double expectedAnswer;

  String get prompt {
    final symbol = switch (operation) {
      MathOperation.addition => '+',
      MathOperation.subtraction => '−',
      MathOperation.multiplication => '×',
      MathOperation.division => '÷',
    };
    return '$left $symbol $right';
  }

  /// Returns true when [input] parses and matches [expectedAnswer] after
  /// half-up rounding to 2 decimal places.
  static bool answersMatch(String input, double expectedAnswer) {
    final parsed = parseAnswer(input);
    if (parsed == null) {
      return false;
    }
    return roundHalfUp(parsed, 2) == expectedAnswer;
  }

  /// Parses a hand-typed answer independently of the keyboard's decimal
  /// separator: the last non-digit character separates the fraction, earlier
  /// ones are grouping marks. Returns null when [input] holds no digits or
  /// any letter.
  static double? parseAnswer(String input) {
    var text = input.trim();
    if (text.isEmpty) {
      return null;
    }

    final negative = text.startsWith('-') || text.startsWith('\u2212');
    if (negative) {
      text = text.substring(1);
    }
    if (RegExp(r'[a-zA-Z]').hasMatch(text)) {
      return null;
    }

    final compact = text.replaceAll(RegExp(r"[\s'\u00A0\u202F]"), '');
    final separator = compact.lastIndexOf(RegExp(r'[^0-9]'));
    final whole = (separator == -1 ? compact : compact.substring(0, separator))
        .replaceAll(RegExp(r'[^0-9]'), '');
    final fraction = separator == -1 ? '' : compact.substring(separator + 1);
    if (whole.isEmpty && fraction.isEmpty) {
      return null;
    }

    final parsed = double.tryParse(
      '${whole.isEmpty ? '0' : whole}.${fraction.isEmpty ? '0' : fraction}',
    );
    if (parsed == null) {
      return null;
    }
    return negative ? -parsed : parsed;
  }
}
