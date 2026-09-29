import 'package:bedrock_launcher/domain/use_cases/get_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/replace_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestrictedAppsSettingsBloc
    extends Bloc<RestrictedAppsSettingsEvent, RestrictedAppsSettingsState> {
  RestrictedAppsSettingsBloc({
    required this.appRouter,
    required this.getRestrictedAppsUseCase,
    required this.replaceRestrictedAppsUseCase,
    required this.listInstalledAppsUseCase,
  }) : super(const RestrictedAppsSettingsState.loading()) {
    on<RestrictedAppsSettingsEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final GetRestrictedAppsUseCase getRestrictedAppsUseCase;
  final ReplaceRestrictedAppsUseCase replaceRestrictedAppsUseCase;
  final ListInstalledAppsUseCase listInstalledAppsUseCase;

  Future<void> _onEvent(
    RestrictedAppsSettingsEvent event,
    Emitter<RestrictedAppsSettingsState> emit,
  ) async {
    await event.when(
      started: () async {
        emit(const RestrictedAppsSettingsState.loading());
        try {
          final restricted = await getRestrictedAppsUseCase();
          final apps = await listInstalledAppsUseCase();
          final sortedApps = [...apps]
            ..sort(
              (a, b) => a.displayName.toLowerCase().compareTo(
                    b.displayName.toLowerCase(),
                  ),
            );
          final restrictedPackageNames = {
            for (final app in restricted) app.packageName,
          };
          emit(
            RestrictedAppsSettingsState.loaded(
              installedApps: sortedApps,
              savedRestrictedPackageNames: restrictedPackageNames,
              draftRestrictedPackageNames: Set<String>.from(
                restrictedPackageNames,
              ),
            ),
          );
        } catch (error) {
          emit(RestrictedAppsSettingsState.error(message: error.toString()));
        }
      },
      backTapped: () async {
        final loaded = state.mapOrNull(loaded: (value) => value);
        if (loaded != null) {
          emit(
            RestrictedAppsSettingsState.closing(
              draftRestrictedPackageNames: loaded.draftRestrictedPackageNames,
            ),
          );
        }
        appRouter.pop();
      },
      saveTapped: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null || !state.hasUnsavedChanges) {
          return;
        }

        emit(current.copyWith(isSaving: true, actionErrorMessage: null));
        try {
          await replaceRestrictedAppsUseCase(
            current.draftRestrictedPackageNames,
          );
          emit(
            current.copyWith(
              savedRestrictedPackageNames: Set<String>.from(
                current.draftRestrictedPackageNames,
              ),
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
      restrictedAppToggled: (packageName) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }

        final draft = Set<String>.from(current.draftRestrictedPackageNames);
        if (!draft.remove(packageName)) {
          draft.add(packageName);
        }

        emit(
          current.copyWith(
            draftRestrictedPackageNames: draft,
            actionErrorMessage: null,
          ),
        );
      },
    );
  }
}
