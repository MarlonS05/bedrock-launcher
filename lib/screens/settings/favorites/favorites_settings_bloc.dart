import 'package:bedrock_launcher/domain/use_cases/prune_uninstalled_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/reorder_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesSettingsBloc
    extends Bloc<FavoritesSettingsEvent, FavoritesSettingsState> {
  FavoritesSettingsBloc({
    required this.appRouter,
    required this.pruneUninstalledFavoriteAppsUseCase,
    required this.reorderFavoriteAppsUseCase,
  }) : super(const FavoritesSettingsState.loading()) {
    on<FavoritesSettingsEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final PruneUninstalledFavoriteAppsUseCase pruneUninstalledFavoriteAppsUseCase;
  final ReorderFavoriteAppsUseCase reorderFavoriteAppsUseCase;

  Future<void> _onEvent(
    FavoritesSettingsEvent event,
    Emitter<FavoritesSettingsState> emit,
  ) async {
    await event.when(
      started: () async {
        emit(const FavoritesSettingsState.loading());
        try {
          final favorites = await pruneUninstalledFavoriteAppsUseCase();
          final packageNames =
              favorites.map((favorite) => favorite.packageName).toList();
          emit(
            FavoritesSettingsState.loaded(
              savedPackageNamesInOrder: packageNames,
              draftPackageNamesInOrder: List<String>.from(packageNames),
            ),
          );
        } catch (error) {
          emit(FavoritesSettingsState.error(message: error.toString()));
        }
      },
      backTapped: () async {
        _pop(emit);
      },
      saveTapped: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null || !state.hasUnsavedChanges) {
          return;
        }

        emit(current.copyWith(isSaving: true, actionErrorMessage: null));
        try {
          await reorderFavoriteAppsUseCase(current.draftPackageNamesInOrder);
          emit(
            current.copyWith(
              savedPackageNamesInOrder:
                  List<String>.from(current.draftPackageNamesInOrder),
              isSaving: false,
              actionErrorMessage: null,
            ),
          );
        } catch (error) {
          emit(
            current.copyWith(
              isSaving: false,
              actionErrorMessage: error.toString(),
            ),
          );
        }
      },
      orderChanged: (packageNamesInOrder) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        emit(
          current.copyWith(
            draftPackageNamesInOrder: List<String>.from(packageNamesInOrder),
            actionErrorMessage: null,
          ),
        );
      },
    );
  }

  void _pop(Emitter<FavoritesSettingsState> emit) {
    final loaded = state.mapOrNull(loaded: (value) => value);
    if (loaded != null) {
      emit(
        FavoritesSettingsState.closing(
          draftPackageNamesInOrder: loaded.draftPackageNamesInOrder,
        ),
      );
    }
    appRouter.pop();
  }
}
