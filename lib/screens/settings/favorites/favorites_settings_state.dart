import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_settings_state.freezed.dart';

@freezed
sealed class FavoritesSettingsState with _$FavoritesSettingsState {
  const FavoritesSettingsState._();

  const factory FavoritesSettingsState.loading() = _Loading;

  const factory FavoritesSettingsState.loaded({
    required List<String> savedPackageNamesInOrder,
    required List<String> draftPackageNamesInOrder,
    @Default(false) bool isSaving,
    String? actionErrorMessage,
  }) = _Loaded;

  const factory FavoritesSettingsState.closing({
    required List<String> draftPackageNamesInOrder,
  }) = _Closing;

  const factory FavoritesSettingsState.error({
    required String message,
  }) = _Error;

  bool get hasUnsavedChanges => maybeMap(
        loaded: (state) {
          final saved = state.savedPackageNamesInOrder;
          final draft = state.draftPackageNamesInOrder;
          if (saved.length != draft.length) {
            return true;
          }
          for (var i = 0; i < saved.length; i++) {
            if (saved[i] != draft[i]) {
              return true;
            }
          }
          return false;
        },
        orElse: () => false,
      );
}
