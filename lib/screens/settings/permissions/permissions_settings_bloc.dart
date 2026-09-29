import 'package:bedrock_launcher/domain/use_cases/open_default_launcher_settings_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsSettingsBloc
    extends Bloc<PermissionsSettingsEvent, PermissionsSettingsState> {
  PermissionsSettingsBloc({
    required this.appRouter,
    required this.openDefaultLauncherSettingsUseCase,
  }) : super(const PermissionsSettingsState.loaded()) {
    on<PermissionsSettingsEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final OpenDefaultLauncherSettingsUseCase openDefaultLauncherSettingsUseCase;

  Future<void> _onEvent(
    PermissionsSettingsEvent event,
    Emitter<PermissionsSettingsState> emit,
  ) async {
    await event.when(
      started: () async {
        emit(const PermissionsSettingsState.loaded());
      },
      backTapped: () async {
        _pop(emit);
      },
      openDefaultLauncherTapped: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null || current.isOpening) {
          return;
        }

        emit(current.copyWith(isOpening: true, actionErrorMessage: null));
        try {
          await openDefaultLauncherSettingsUseCase();
          emit(current.copyWith(isOpening: false, actionErrorMessage: null));
        } catch (error) {
          emit(
            current.copyWith(
              isOpening: false,
              actionErrorMessage: error.toString(),
            ),
          );
        }
      },
    );
  }

  void _pop(Emitter<PermissionsSettingsState> emit) {
    emit(const PermissionsSettingsState.closing());
    appRouter.pop();
  }
}
