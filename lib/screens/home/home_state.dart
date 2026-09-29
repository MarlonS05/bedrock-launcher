import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;

  const factory HomeState.loaded({
    required List<LauncherApp> apps,
    required int themeColorArgb,
    required bool useWhiteText,
    required bool showTileSeparators,
    required LauncherAppFont appFont,
    required Set<String> restrictedPackageNames,
    int? batteryLevel,
    String? pendingRestrictedLaunchPackageName,
    @Default(false) bool pendingMathPractice,
  }) = _Loaded;

  const factory HomeState.error({required String message}) = _Error;
}
