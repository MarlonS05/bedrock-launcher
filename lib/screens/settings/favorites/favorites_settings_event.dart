import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_settings_event.freezed.dart';

@freezed
sealed class FavoritesSettingsEvent with _$FavoritesSettingsEvent {
  const factory FavoritesSettingsEvent.started() = _Started;

  const factory FavoritesSettingsEvent.backTapped() = _BackTapped;

  const factory FavoritesSettingsEvent.saveTapped() = _SaveTapped;

  const factory FavoritesSettingsEvent.orderChanged(
    List<String> packageNamesInOrder,
  ) = _OrderChanged;
}
