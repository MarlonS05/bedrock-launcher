import 'dart:math';

import 'package:bedrock_launcher/domain/math/math_operation.dart';
import 'package:bedrock_launcher/domain/math/math_problem.dart';
import 'package:bedrock_launcher/domain/math/math_problem_generator.dart';
import 'package:bedrock_launcher/domain/math/round_half_up.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('roundHalfUp', () {
    test('rounds 1-4 down and 5-9 up at two decimals', () {
      expect(roundHalfUp(1.234, 2), 1.23);
      expect(roundHalfUp(1.235, 2), 1.24);
      expect(roundHalfUp(1.239, 2), 1.24);
      expect(roundHalfUp(-1.235, 2), -1.24);
    });
  });

  group('MathProblem.answersMatch', () {
    test('accepts any keyboard decimal separator', () {
      expect(MathProblem.answersMatch('3.29', 3.29), isTrue);
      expect(MathProblem.answersMatch('3,29', 3.29), isTrue);
      expect(MathProblem.answersMatch('3\u066B29', 3.29), isTrue);
      expect(MathProblem.answersMatch('3\uFF0E29', 3.29), isTrue);
      expect(MathProblem.answersMatch(' 3.29 ', 3.29), isTrue);
    });

    test('accepts answers below 1 without a leading zero', () {
      expect(MathProblem.answersMatch(',5', 0.5), isTrue);
      expect(MathProblem.answersMatch('.5', 0.5), isTrue);
      expect(MathProblem.answersMatch('0,50', 0.5), isTrue);
    });

    test('handles grouping marks and negative answers', () {
      expect(MathProblem.answersMatch('1.234,56', 1234.56), isTrue);
      expect(MathProblem.answersMatch('1 234.56', 1234.56), isTrue);
      expect(MathProblem.answersMatch('-3,29', -3.29), isTrue);
    });

    test('rejects wrong, empty and non-numeric answers', () {
      expect(MathProblem.answersMatch('1.23', 1.24), isFalse);
      expect(MathProblem.answersMatch('abc', 1.24), isFalse);
      expect(MathProblem.answersMatch('.', 1.24), isFalse);
      expect(MathProblem.answersMatch('', 1.24), isFalse);
    });
  });

  group('MathProblemGenerator', () {
    test('generates operands within default digit ranges', () {
      final generator = MathProblemGenerator(random: Random(42));

      for (var i = 0; i < 100; i++) {
        final addition = generator.generate(operation: MathOperation.addition);
        expect(addition.left, inInclusiveRange(0, 999999));
        expect(addition.right, inInclusiveRange(0, 999999));
        expect(addition.expectedAnswer, addition.left + addition.right);

        final subtraction =
            generator.generate(operation: MathOperation.subtraction);
        expect(subtraction.left, greaterThanOrEqualTo(subtraction.right));
        expect(subtraction.left, inInclusiveRange(0, 999999));
        expect(subtraction.right, inInclusiveRange(0, 999999));

        final multiplication =
            generator.generate(operation: MathOperation.multiplication);
        expect(multiplication.left, inInclusiveRange(0, 99));
        expect(multiplication.right, inInclusiveRange(0, 99));

        final division = generator.generate(operation: MathOperation.division);
        expect(division.left, inInclusiveRange(0, 999));
        expect(division.right, inInclusiveRange(1, 999));
        expect(
          division.expectedAnswer,
          roundHalfUp(division.left / division.right, 2),
        );
      }
    });
  });
}
