import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_apps_event.freezed.dart';

@freezed
sealed class AllAppsEvent with _$AllAppsEvent {
  const factory AllAppsEvent.started() = _Started;

  const factory AllAppsEvent.appsLoadRequested({
    @Default(false) bool preserveSearch,
    @Default(false) bool forceRefresh,
  }) = _AppsLoadRequested;

  const factory AllAppsEvent.searchQueryChanged(String query) =
      _SearchQueryChanged;

  const factory AllAppsEvent.searchSubmitted() = _SearchSubmitted;

  const factory AllAppsEvent.appTapped(String packageName) = _AppTapped;

  const factory AllAppsEvent.favoriteToggled(String packageName) =
      _FavoriteToggled;

  const factory AllAppsEvent.uninstallTapped(String packageName) =
      _UninstallTapped;

  const factory AllAppsEvent.openAppSettingsTapped(String packageName) =
      _OpenAppSettingsTapped;

  const factory AllAppsEvent.resumed() = _Resumed;

  const factory AllAppsEvent.refreshTapped() = _RefreshTapped;

  const factory AllAppsEvent.retryTapped() = _RetryTapped;

  const factory AllAppsEvent.backTapped() = _BackTapped;

  const factory AllAppsEvent.restrictedLaunchConfirmed() =
      _RestrictedLaunchConfirmed;

  const factory AllAppsEvent.restrictedLaunchCancelled() =
      _RestrictedLaunchCancelled;
}
