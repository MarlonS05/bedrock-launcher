import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_apps_state.freezed.dart';

@freezed
sealed class AllAppsState with _$AllAppsState {
  const factory AllAppsState.loading() = _Loading;

  const factory AllAppsState.loaded({
    required List<LauncherApp> allApps,
    required List<LauncherApp> filteredApps,
    required String searchQuery,
    required int themeColorArgb,
    required bool useWhiteText,
    required bool showTileSeparators,
    required LauncherAppFont appFont,
    required Set<String> favoritePackageNames,
    @Default(false) bool isAppsLoading,
    String? pendingRestrictedLaunchPackageName,
  }) = _Loaded;

  const factory AllAppsState.error({required String message}) = _Error;
}
