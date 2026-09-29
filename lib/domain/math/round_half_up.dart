/// Rounds [value] half-up to [fractionDigits] decimal places.
///
/// Digits 1–4 after the cutoff round down; 5–9 round up (away from zero for
/// positive values; toward −∞ for the half case on negatives is avoided by
/// working on the absolute scaled value then restoring the sign).
double roundHalfUp(double value, int fractionDigits) {
  if (fractionDigits < 0) {
    throw ArgumentError.value(
      fractionDigits,
      'fractionDigits',
      'must be >= 0',
    );
  }

  var factor = 1;
  for (var i = 0; i < fractionDigits; i++) {
    factor *= 10;
  }

  final signed = value < 0;
  final scaled = value.abs() * factor;
  final whole = scaled.floorToDouble();
  final fraction = scaled - whole;
  final roundedScaled = fraction >= 0.5 ? whole + 1 : whole;
  final result = roundedScaled / factor;
  return signed ? -result : result;
}
