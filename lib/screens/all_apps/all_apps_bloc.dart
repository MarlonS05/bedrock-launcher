import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/use_cases/add_favorite_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/load_launcher_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_app_settings_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/remove_favorite_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/uninstall_app_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_event.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAppsBloc extends Bloc<AllAppsEvent, AllAppsState> {
  AllAppsBloc({
    required this.appRouter,
    required this.getAppearancePreferencesUseCase,
    required this.loadLauncherAppsUseCase,
    required this.launchAppUseCase,
    required this.addFavoriteAppUseCase,
    required this.removeFavoriteAppUseCase,
    required this.uninstallAppUseCase,
    required this.openAppSettingsUseCase,
    required this.installedFontsPort,
  }) : super(const AllAppsState.loading()) {
    on<AllAppsEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final GetAppearancePreferencesUseCase getAppearancePreferencesUseCase;
  final LoadLauncherAppsUseCase loadLauncherAppsUseCase;
  final LaunchAppUseCase launchAppUseCase;
  final AddFavoriteAppUseCase addFavoriteAppUseCase;
  final RemoveFavoriteAppUseCase removeFavoriteAppUseCase;
  final UninstallAppUseCase uninstallAppUseCase;
  final OpenAppSettingsUseCase openAppSettingsUseCase;
  final InstalledFontsPort installedFontsPort;

  Future<void> _onEvent(AllAppsEvent event, Emitter<AllAppsState> emit) async {
    await event.when(
      started: () async {
        await _loadShell(emit);
        add(const AllAppsEvent.appsLoadRequested());
      },
      appsLoadRequested: (preserveSearch, forceRefresh) => _loadAppsList(
        emit,
        preserveSearch: preserveSearch,
        forceRefresh: forceRefresh,
      ),
      searchSubmitted: () async => _launchTopFilteredApp(emit),
      retryTapped: () async {
        await _loadShell(emit);
        add(const AllAppsEvent.appsLoadRequested());
      },
      resumed: () async {
        final existingLoaded = state.mapOrNull(loaded: (value) => value);
        if (existingLoaded != null) {
          emit(existingLoaded.copyWith(isAppsLoading: true));
        } else {
          await _loadShell(emit);
        }
        add(const AllAppsEvent.appsLoadRequested(preserveSearch: true));
      },
      refreshTapped: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }
        emit(current.copyWith(isAppsLoading: true));
        add(
          const AllAppsEvent.appsLoadRequested(
            preserveSearch: true,
            forceRefresh: true,
          ),
        );
      },
      searchQueryChanged: (query) async => _updateSearchQuery(emit, query),
      appTapped: (packageName) async {
        await _requestLaunch(emit, packageName);
      },
      favoriteToggled: (packageName) async =>
          _toggleFavorite(emit, packageName),
      uninstallTapped: (packageName) async =>
          _uninstallApp(emit, packageName),
      openAppSettingsTapped: (packageName) async {
        await openAppSettingsUseCase(packageName);
      },
      backTapped: () async {
        appRouter.pop();
      },
      restrictedLaunchConfirmed: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        final packageName = current?.pendingRestrictedLaunchPackageName;
        if (current == null || packageName == null) {
          return;
        }
        emit(current.copyWith(pendingRestrictedLaunchPackageName: null));
        await launchAppUseCase(packageName);
        appRouter.goHome();
      },
      restrictedLaunchCancelled: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }
        emit(current.copyWith(pendingRestrictedLaunchPackageName: null));
      },
    );
  }

  Future<void> _loadShell(Emitter<AllAppsState> emit) async {
    final existingLoaded = state.mapOrNull(loaded: (value) => value);

    if (existingLoaded == null) {
      emit(const AllAppsState.loading());
    }

    try {
      final appearance = await getAppearancePreferencesUseCase();
      await installedFontsPort.loadFont(appearance.appFont.familyId);

      emit(
        AllAppsState.loaded(
          allApps: const [],
          filteredApps: const [],
          searchQuery: existingLoaded?.searchQuery ?? '',
          themeColorArgb: appearance.themeColorArgb,
          useWhiteText: appearance.textColor == LauncherTextColor.white,
          showTileSeparators: appearance.showTileSeparators,
          appFont: appearance.appFont,
          favoritePackageNames: const {},
          isAppsLoading: true,
        ),
      );
    } catch (error) {
      emit(AllAppsState.error(message: error.toString()));
    }
  }

  Future<void> _loadAppsList(
    Emitter<AllAppsState> emit, {
    bool preserveSearch = false,
    bool forceRefresh = false,
  }) async {
    final shell = state.mapOrNull(loaded: (value) => value);
    if (shell == null) {
      return;
    }

    final previousSearchQuery = preserveSearch ? shell.searchQuery : '';

    if (!preserveSearch && shell.searchQuery.isNotEmpty) {
      emit(shell.copyWith(searchQuery: '', filteredApps: const []));
    }

    try {
      final snapshot = await loadLauncherAppsUseCase(
        forceRefresh: forceRefresh,
      );
      final apps = snapshot.installedApps;
      final favoritePackageNames = snapshot.favoritePackageNames;

      final currentSearchQuery = state.mapOrNull(
            loaded: (value) => value.searchQuery,
          ) ??
          previousSearchQuery;
      final normalizedQuery = currentSearchQuery.trim().toLowerCase();
      final filteredApps = normalizedQuery.isEmpty
          ? apps
          : apps
              .where(
                (app) =>
                    app.displayName.toLowerCase().contains(normalizedQuery),
              )
              .toList();

      emit(
        shell.copyWith(
          allApps: apps,
          filteredApps: filteredApps,
          searchQuery: currentSearchQuery,
          favoritePackageNames: favoritePackageNames,
          isAppsLoading: false,
          pendingRestrictedLaunchPackageName: null,
        ),
      );
    } catch (error) {
      emit(AllAppsState.error(message: error.toString()));
    }
  }

  Future<void> _uninstallApp(
    Emitter<AllAppsState> emit,
    String packageName,
  ) async {
    try {
      await uninstallAppUseCase(packageName);
    } catch (error) {
      emit(AllAppsState.error(message: error.toString()));
    }
  }

  Future<void> _toggleFavorite(
    Emitter<AllAppsState> emit,
    String packageName,
  ) async {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null) {
      return;
    }

    try {
      final updatedFavorites = Set<String>.from(current.favoritePackageNames);
      if (updatedFavorites.contains(packageName)) {
        await removeFavoriteAppUseCase(packageName);
        updatedFavorites.remove(packageName);
      } else {
        await addFavoriteAppUseCase(packageName);
        updatedFavorites.add(packageName);
      }

      emit(current.copyWith(favoritePackageNames: updatedFavorites));
    } catch (error) {
      emit(AllAppsState.error(message: error.toString()));
    }
  }

  Future<void> _launchTopFilteredApp(Emitter<AllAppsState> emit) async {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null ||
        current.searchQuery.trim().isEmpty ||
        current.filteredApps.isEmpty) {
      return;
    }
    await _requestLaunch(emit, current.filteredApps.first.packageName);
  }

  Future<void> _requestLaunch(
    Emitter<AllAppsState> emit,
    String packageName,
  ) async {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null) {
      return;
    }

    final appIndex = current.allApps.indexWhere(
      (app) => app.packageName == packageName,
    );
    final isRestricted = appIndex >= 0 && current.allApps[appIndex].isRestricted;
    if (isRestricted) {
      emit(
        current.copyWith(pendingRestrictedLaunchPackageName: packageName),
      );
      return;
    }

    await launchAppUseCase(packageName);
    appRouter.goHome();
  }

  void _updateSearchQuery(Emitter<AllAppsState> emit, String query) {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null) {
      return;
    }

    final normalizedQuery = query.trim().toLowerCase();
    final filteredApps = normalizedQuery.isEmpty
        ? current.allApps
        : current.allApps
            .where(
              (app) =>
                  app.displayName.toLowerCase().contains(normalizedQuery),
            )
            .toList();

    emit(
      current.copyWith(
        searchQuery: query,
        filteredApps: filteredApps,
      ),
    );
  }
}
