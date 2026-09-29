import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/settings_event.dart';
import 'package:bedrock_launcher/screens/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.appRouter})
      : super(const SettingsState.loaded()) {
    on<SettingsEvent>(_onEvent);
  }

  final AppRouter appRouter;

  Future<void> _onEvent(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await event.when(
      started: () async {
        emit(const SettingsState.loaded());
      },
      backTapped: () async {
        emit(const SettingsState.closing());
        appRouter.pop();
      },
      appearanceTapped: () async {
        appRouter.goSettingsAppearance();
      },
      permissionsTapped: () async {
        appRouter.goSettingsPermissions();
      },
      favoritesTapped: () async {
        appRouter.goSettingsFavorites();
      },
      preferredAppsTapped: () async {
        appRouter.goSettingsPreferredApps();
      },
      restrictedAppsTapped: () async {
        appRouter.goSettingsRestrictedApps();
      },
    );
  }
}
