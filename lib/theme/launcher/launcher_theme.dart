import 'package:bedrock_launcher/theme/app_spacing.dart';

abstract final class LauncherTheme {
  static const listTopSpacerFraction = 1 / 3;
  static const listPaddingHorizontal = AppSpacing.md;
  static const listItemPaddingVertical = AppSpacing.md;
  static const appNamePressScale = 0.97;
  static const appNamePressDuration = Duration(milliseconds: 100);
  static const appNamePressedOpacity = 0.7;
  static const listSeparatorHeight = 1.0;
  static const dialogBorderRadius = AppSpacing.md;
  static const cornerSlotSize = 48.0;
  static const cornerInset = AppSpacing.md;
  static const browserSwipeZoneFraction = 0.5;
  static const browserSwipeMinDistance = 48.0;
  static const clockSizeFraction = 0.55;
  static const clockMaxWidthFraction = 0.38;
  static const clockRingStrokeWidth = 3.0;
  static const clockHandMinuteReachFraction = 0.72;
  static const clockHandHourReachFraction = 0.5;
  static const clockRingHandGap = 6.0;
  static const clockHandHourWidth = 3.0;
  static const clockHandMinuteWidth = 2.0;
  static const clockHourTickInnerRadiusFraction = 0.62;
  static const clockHourTickOuterRadiusFraction = 0.65;
  static const clockHourTickStrokeWidth = 1.0;
  static const clockQuarterTickInnerRadiusFraction = 0.56;
  static const clockQuarterTickOuterRadiusFraction = 0.70;
  static const clockQuarterTickStrokeWidth = 2.0;
  static const clockHourTickOpacity = 0.5;
}
