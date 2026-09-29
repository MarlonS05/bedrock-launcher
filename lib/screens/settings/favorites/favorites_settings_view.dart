import 'package:bedrock_launcher/screens/components/win95/win95_button.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_desktop.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_explorer_viewport.dart';
import 'package:bedrock_launcher/screens/components/win95/win95_window_frame.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_state.dart';
import 'package:bedrock_launcher/theme/app_spacing.dart';
import 'package:bedrock_launcher/theme/win95/win95_colors.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:bedrock_launcher/theme/win95/win95_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesSettingsView extends StatelessWidget {
  const FavoritesSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context
              .read<FavoritesSettingsBloc>()
              .add(const FavoritesSettingsEvent.backTapped());
        }
      },
      child: Win95Desktop(
        child: BlocBuilder<FavoritesSettingsBloc, FavoritesSettingsState>(
          builder: (context, state) {
            return state.when(
              loading: () => const _FavoritesWindow(
                child: Center(child: CircularProgressIndicator()),
              ),
              loaded:
                  (
                    savedPackageNamesInOrder,
                    draftPackageNamesInOrder,
                    isSaving,
                    actionErrorMessage,
                  ) =>
                      _FavoritesWindow(
                packageNamesInOrder: draftPackageNamesInOrder,
                hasUnsavedChanges: state.hasUnsavedChanges,
                isSaving: isSaving,
                errorMessage: actionErrorMessage,
              ),
              closing: (draftPackageNamesInOrder) => _FavoritesWindow(
                packageNamesInOrder: draftPackageNamesInOrder,
                backPressed: true,
              ),
              error: (message) => _FavoritesWindow(
                errorMessage: message,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FavoritesWindow extends StatelessWidget {
  const _FavoritesWindow({
    this.packageNamesInOrder,
    this.errorMessage,
    this.hasUnsavedChanges = false,
    this.isSaving = false,
    this.backPressed = false,
    this.child,
  });

  final List<String>? packageNamesInOrder;
  final String? errorMessage;
  final bool hasUnsavedChanges;
  final bool isSaving;
  final bool backPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoritesSettingsBloc>();

    return Win95WindowFrame(
      title: 'Favorites',
      fillScreen: true,
      onClose: () => bloc.add(const FavoritesSettingsEvent.backTapped()),
      child: Padding(
        padding: const EdgeInsets.all(Win95Theme.windowPadding),
        child: child ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Win95ExplorerViewport(
                    child: packageNamesInOrder == null
                        ? const SizedBox.shrink()
                        : packageNamesInOrder!.isEmpty
                            ? Center(
                                child: Text(
                                  'No favorites yet',
                                  style: Win95Typography.body,
                                ),
                              )
                            : ReorderableListView.builder(
                                buildDefaultDragHandles: false,
                                padding: const EdgeInsets.all(AppSpacing.xs),
                                itemCount: packageNamesInOrder!.length,
                                onReorderItem: (oldIndex, newIndex) {
                                  final reordered =
                                      List<String>.from(packageNamesInOrder!);
                                  final item = reordered.removeAt(oldIndex);
                                  reordered.insert(newIndex, item);
                                  bloc.add(
                                    FavoritesSettingsEvent.orderChanged(
                                      reordered,
                                    ),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final packageName =
                                      packageNamesInOrder![index];
                                  return _FavoriteAppRow(
                                    key: ValueKey(packageName),
                                    index: index,
                                    packageName: packageName,
                                  );
                                },
                              ),
                  ),
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    errorMessage!,
                    style: Win95Typography.body.copyWith(
                      color: Colors.red.shade900,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Win95Button(
                      label: 'Save',
                      fullWidth: true,
                      enabled: hasUnsavedChanges && !isSaving,
                      onPressed: hasUnsavedChanges && !isSaving
                          ? () => bloc.add(
                                const FavoritesSettingsEvent.saveTapped(),
                              )
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Win95Button(
                      label: '<< back',
                      fullWidth: true,
                      forcedPressed: backPressed,
                      onPressed: () =>
                          bloc.add(const FavoritesSettingsEvent.backTapped()),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}

class _FavoriteAppRow extends StatelessWidget {
  const _FavoriteAppRow({
    required super.key,
    required this.index,
    required this.packageName,
  });

  final int index;
  final String packageName;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs / 2),
        child: Row(
          children: [
            ReorderableDragStartListener(
              index: index,
              child: SizedBox(
                width: Win95Theme.minTouchTarget,
                height: Win95Theme.minTouchTarget,
                child: Icon(
                  Icons.drag_handle,
                  color: Win95Colors.text,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                packageName,
                style: Win95Typography.body,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
