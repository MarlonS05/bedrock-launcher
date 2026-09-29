import 'dart:math' as math;

import 'package:bedrock_launcher/screens/components/launcher/launcher_analog_clock.dart';
import 'package:bedrock_launcher/screens/components/launcher/camera_corner_icon.dart';
import 'package:bedrock_launcher/screens/components/launcher/phone_corner_icon.dart';
import 'package:bedrock_launcher/screens/components/launcher/settings_corner_icon.dart';
import 'package:bedrock_launcher/screens/components/launcher/browser_swipe_zone.dart';
import 'package:bedrock_launcher/screens/components/launcher/corner_action_slot.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_app_list.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_background.dart';
import 'package:bedrock_launcher/screens/components/launcher/math_hurdle_dialog.dart';
import 'package:bedrock_launcher/screens/home/home_bloc.dart';
import 'package:bedrock_launcher/screens/home/home_event.dart';
import 'package:bedrock_launcher/screens/home/home_state.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              current.mapOrNull(error: (_) => true) ?? false,
          listener: (context, state) {
            state.mapOrNull(
              error: (errorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorState.message)),
                );
              },
            );
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            final previousPending = previous.mapOrNull(
              loaded: (value) => value.pendingRestrictedLaunchPackageName,
            );
            final currentPending = current.mapOrNull(
              loaded: (value) => value.pendingRestrictedLaunchPackageName,
            );
            return currentPending != null && currentPending != previousPending;
          },
          listener: (context, state) async {
            final loaded = state.mapOrNull(loaded: (value) => value);
            if (loaded == null ||
                loaded.pendingRestrictedLaunchPackageName == null) {
              return;
            }

            final bloc = context.read<HomeBloc>();
            final textColor = loaded.useWhiteText
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF000000);
            final passed = await MathHurdleDialog.show(
              context: context,
              backgroundColor: Color(loaded.themeColorArgb),
              textColor: textColor,
            );
            if (!context.mounted) {
              return;
            }
            if (passed == true) {
              bloc.add(const HomeEvent.restrictedLaunchConfirmed());
            } else {
              bloc.add(const HomeEvent.restrictedLaunchCancelled());
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            final wasPending = previous.mapOrNull(
                  loaded: (value) => value.pendingMathPractice,
                ) ??
                false;
            final isPending = current.mapOrNull(
                  loaded: (value) => value.pendingMathPractice,
                ) ??
                false;
            return !wasPending && isPending;
          },
          listener: (context, state) async {
            final loaded = state.mapOrNull(loaded: (value) => value);
            if (loaded == null || !loaded.pendingMathPractice) {
              return;
            }

            final bloc = context.read<HomeBloc>();
            final textColor = loaded.useWhiteText
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF000000);
            await MathHurdleDialog.show(
              context: context,
              backgroundColor: Color(loaded.themeColorArgb),
              textColor: textColor,
            );
            if (!context.mounted) {
              return;
            }
            bloc.add(const HomeEvent.mathPracticeDismissed());
          },
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final bloc = context.read<HomeBloc>();
          final textColor = state.maybeMap(
            loaded: (loadedState) => loadedState.useWhiteText
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF000000),
            orElse: () => const Color(0xFFFFFFFF),
          );

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                state.maybeMap(
                  loaded: (loadedState) => LauncherBackground(
                    color: Color(loadedState.themeColorArgb),
                  ),
                  orElse: () => const LauncherBackground(),
                ),
                SafeArea(
                  child: state.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (
                      apps,
                      themeColorArgb,
                      useWhiteText,
                      showTileSeparators,
                      appFont,
                      restrictedPackageNames,
                      batteryLevel,
                      pendingRestrictedLaunchPackageName,
                      pendingMathPractice,
                    ) {
                      final screenSize = MediaQuery.sizeOf(context);
                      final topSpacerHeight =
                          screenSize.height *
                              LauncherTheme.listTopSpacerFraction;
                      final clockSize = math.min(
                        topSpacerHeight * LauncherTheme.clockSizeFraction,
                        screenSize.width * LauncherTheme.clockMaxWidthFraction,
                      );

                      return Column(
                        children: [
                          SizedBox(
                            height: topSpacerHeight,
                            child: Center(
                              child: LauncherAnalogClock(
                                batteryLevel: batteryLevel,
                                color: textColor,
                                size: clockSize,
                                onResume: () => bloc.add(
                                  const HomeEvent.batteryRefreshRequested(),
                                ),
                                onTap: () =>
                                    bloc.add(const HomeEvent.clockTapped()),
                              ),
                            ),
                          ),
                          Expanded(
                            child: LauncherAppList(
                              apps: apps,
                              textColor: textColor,
                              appFont: appFont,
                              showSeparators: showTileSeparators,
                              scrollable: false,
                              onAppTap: (packageName) {
                                final index = apps.indexWhere(
                                  (app) => app.packageName == packageName,
                                );
                                if (index >= 0) {
                                  bloc.add(HomeEvent.appTapped(index));
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    error: (message) => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(message),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () =>
                                bloc.add(const HomeEvent.retryTapped()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BrowserSwipeZone(
                  onSwipeUp: () =>
                      bloc.add(const HomeEvent.browserSwipeUpDetected()),
                  onSwipeLeft: () => bloc.add(const HomeEvent.allAppsTapped()),
                  onDoubleTap: () =>
                      bloc.add(const HomeEvent.browserDoubleTapped()),
                ),
                const CornerActionSlot(alignment: CornerAlignment.topLeft),
                const CornerActionSlot(alignment: CornerAlignment.topRight),
                CornerActionSlot(
                  alignment: CornerAlignment.bottomLeft,
                  onTap: () => bloc.add(const HomeEvent.phoneTapped()),
                  child: PhoneCornerIcon(color: textColor),
                ),
                CornerActionSlot(
                  alignment: CornerAlignment.bottomRight,
                  stackIndex: 1,
                  onTap: () => bloc.add(const HomeEvent.settingsTapped()),
                  child: SettingsCornerIcon(color: textColor),
                ),
                CornerActionSlot(
                  alignment: CornerAlignment.bottomRight,
                  onTap: () => bloc.add(const HomeEvent.cameraTapped()),
                  onLongPress: () =>
                      bloc.add(const HomeEvent.cameraLongPressed()),
                  child: CameraCornerIcon(color: textColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
