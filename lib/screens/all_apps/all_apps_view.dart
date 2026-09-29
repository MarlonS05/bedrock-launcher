import 'package:bedrock_launcher/screens/all_apps/all_apps_bloc.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_event.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_state.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_app_action_dialog.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_app_list.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_background.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_search_field.dart';
import 'package:bedrock_launcher/screens/components/launcher/math_hurdle_dialog.dart';
import 'package:bedrock_launcher/theme/launcher/launcher_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAppsView extends StatefulWidget {
  const AllAppsView({super.key});

  @override
  State<AllAppsView> createState() => _AllAppsViewState();
}

class _AllAppsViewState extends State<AllAppsView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AllAppsBloc>().add(const AllAppsEvent.resumed());
    }
  }

  void _showAppActionDialog({
    required BuildContext context,
    required AllAppsBloc bloc,
    required String packageName,
    required String displayName,
    required bool isFavorite,
    required Color backgroundColor,
    required Color textColor,
  }) {
    LauncherAppActionDialog.show(
      context: context,
      displayName: displayName,
      packageName: packageName,
      isFavorite: isFavorite,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onFavoriteToggled: () => bloc.add(
        AllAppsEvent.favoriteToggled(packageName),
      ),
      onUninstall: () => bloc.add(
        AllAppsEvent.uninstallTapped(packageName),
      ),
      onOpenAppSettings: () => bloc.add(
        AllAppsEvent.openAppSettingsTapped(packageName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AllAppsBloc, AllAppsState>(
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
        BlocListener<AllAppsBloc, AllAppsState>(
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

            final bloc = context.read<AllAppsBloc>();
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
              bloc.add(const AllAppsEvent.restrictedLaunchConfirmed());
            } else {
              bloc.add(const AllAppsEvent.restrictedLaunchCancelled());
            }
          },
        ),
      ],
      child: BlocBuilder<AllAppsBloc, AllAppsState>(
        builder: (context, state) {
          final bloc = context.read<AllAppsBloc>();

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
                      allApps,
                      filteredApps,
                      searchQuery,
                      themeColorArgb,
                      useWhiteText,
                      showTileSeparators,
                      appFont,
                      favoritePackageNames,
                      isAppsLoading,
                      pendingRestrictedLaunchPackageName,
                    ) {
                      final textColor = useWhiteText
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF000000);
                      final backgroundColor = Color(themeColorArgb);

                      return Column(
                        children: [
                          LauncherSearchField(
                            textColor: textColor,
                            appFont: appFont,
                            onChanged: (query) => bloc.add(
                              AllAppsEvent.searchQueryChanged(query),
                            ),
                            onSubmitted: () => bloc.add(
                              const AllAppsEvent.searchSubmitted(),
                            ),
                            trailing: _SearchRefreshButton(
                              color: textColor,
                              onPressed: isAppsLoading
                                  ? null
                                  : () => bloc.add(
                                        const AllAppsEvent.refreshTapped(),
                                      ),
                            ),
                          ),
                          Expanded(
                            child: isAppsLoading && filteredApps.isEmpty
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: textColor,
                                    ),
                                  )
                                : LauncherAppList(
                                    apps: filteredApps,
                                    textColor: textColor,
                                    appFont: appFont,
                                    showSeparators: showTileSeparators,
                                    onAppTap: (packageName) => bloc.add(
                                      AllAppsEvent.appTapped(packageName),
                                    ),
                                    onAppLongPress: (packageName) {
                                      final app = allApps.firstWhere(
                                        (entry) =>
                                            entry.packageName == packageName,
                                      );
                                      _showAppActionDialog(
                                        context: context,
                                        bloc: bloc,
                                        packageName: packageName,
                                        displayName: app.displayName,
                                        isFavorite: favoritePackageNames
                                            .contains(packageName),
                                        backgroundColor: backgroundColor,
                                        textColor: textColor,
                                      );
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
                                bloc.add(const AllAppsEvent.retryTapped()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchRefreshButton extends StatelessWidget {
  const _SearchRefreshButton({required this.color, this.onPressed});

  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
      color: color,
      disabledColor: color.withValues(alpha: 0.5),
      tooltip: 'Reload apps',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(
        width: LauncherTheme.cornerSlotSize,
        height: LauncherTheme.cornerSlotSize,
      ),
    );
  }
}
