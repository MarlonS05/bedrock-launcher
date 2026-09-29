import 'dart:math';

import 'package:bedrock_launcher/domain/math/math_operation.dart';
import 'package:bedrock_launcher/domain/math/math_problem.dart';
import 'package:bedrock_launcher/domain/math/math_problem_config.dart';
import 'package:bedrock_launcher/domain/math/round_half_up.dart';

/// Generates a random [MathProblem] for the restricted-app hurdle.
class MathProblemGenerator {
  MathProblemGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  MathProblem generate({MathOperation? operation}) {
    final op = operation ??
        MathOperation.values[_random.nextInt(MathOperation.values.length)];
    return switch (op) {
      MathOperation.addition => _addition(),
      MathOperation.subtraction => _subtraction(),
      MathOperation.multiplication => _multiplication(),
      MathOperation.division => _division(),
    };
  }

  MathProblem _addition() {
    final left = _randomOperand(MathProblemConfig.additionLeftDigits);
    final right = _randomOperand(MathProblemConfig.additionRightDigits);
    return MathProblem(
      operation: MathOperation.addition,
      left: left,
      right: right,
      expectedAnswer: roundHalfUp((left + right).toDouble(), 2),
    );
  }

  MathProblem _subtraction() {
    final a = _randomOperand(MathProblemConfig.subtractionLeftDigits);
    final b = _randomOperand(MathProblemConfig.subtractionRightDigits);
    final left = max(a, b);
    final right = min(a, b);
    return MathProblem(
      operation: MathOperation.subtraction,
      left: left,
      right: right,
      expectedAnswer: roundHalfUp((left - right).toDouble(), 2),
    );
  }

  MathProblem _multiplication() {
    final left = _randomOperand(MathProblemConfig.multiplicationLeftDigits);
    final right = _randomOperand(MathProblemConfig.multiplicationRightDigits);
    return MathProblem(
      operation: MathOperation.multiplication,
      left: left,
      right: right,
      expectedAnswer: roundHalfUp((left * right).toDouble(), 2),
    );
  }

  MathProblem _division() {
    final left = _randomOperand(MathProblemConfig.divisionLeftDigits);
    final right = _randomOperand(
      MathProblemConfig.divisionRightDigits,
      minInclusive: 1,
    );
    return MathProblem(
      operation: MathOperation.division,
      left: left,
      right: right,
      expectedAnswer: roundHalfUp(left / right, 2),
    );
  }

  int _randomOperand(double digits, {int minInclusive = 0}) {
    final maxInclusive = _maxValueForDigits(digits.toInt());
    final effectiveMin = min(minInclusive, maxInclusive);
    return _randomInt(effectiveMin, maxInclusive);
  }

  int _maxValueForDigits(int digits) {
    var maxValue = 1;
    for (var i = 0; i < digits; i++) {
      maxValue *= 10;
    }
    return maxValue - 1;
  }

  int _randomInt(int minInclusive, int maxInclusive) {
    return minInclusive + _random.nextInt(maxInclusive - minInclusive + 1);
  }
}
