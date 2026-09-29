/// Digit limits for each side of every math hurdle operation.
///
/// Edit these values to change how hard the restricted-app math hurdle is.
/// Each value is the maximum number of digits for that operand
/// (e.g. `3` → values from 0…999, or 1…999 for a division divisor).
abstract final class MathProblemConfig {
  static const double additionLeftDigits = 6;
  static const double additionRightDigits = 6;

  static const double subtractionLeftDigits = 5;
  static const double subtractionRightDigits = 5;

  static const double multiplicationLeftDigits = 2;
  static const double multiplicationRightDigits = 2;

  static const double divisionLeftDigits = 3;
  static const double divisionRightDigits = 2;
}
