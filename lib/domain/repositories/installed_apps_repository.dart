import 'package:bedrock_launcher/domain/entities/launcher_app.dart';

abstract class InstalledAppsRepository {
  /// Synchronous peek at the in-memory cache, or `null` when empty.
  List<LauncherApp>? get cached;

  /// Returns cached apps when available, otherwise fetches from the platform.
  ///
  /// When [forceRefresh] is true, always fetches and updates the cache.
  Future<List<LauncherApp>> getInstalledApps({bool forceRefresh = false});

  /// Clears the in-memory cache so the next read hits the platform.
  void invalidate();
}
