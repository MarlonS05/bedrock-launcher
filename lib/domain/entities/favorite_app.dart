/// A user-pinned app stored in the launcher database.
///
/// The [packageName] is the stable app identifier from the Android package
/// manager — the same value as `Application.packageName` from the
/// `device_apps` plugin. Resolve or launch favorited apps via
/// `InstalledAppsPort` use cases (e.g. `LaunchAppUseCase`), not by calling
/// `DeviceApps` from domain code.
class FavoriteApp {
  const FavoriteApp({
    this.id,
    required this.packageName,
    required this.order,
  });

  /// Database row id. Null only before the first insert.
  final int? id;

  /// Android package name (e.g. `com.example.app`).
  final String packageName;

  /// Zero-based display position; lower values appear first.
  final int order;

  FavoriteApp copyWith({
    int? id,
    String? packageName,
    int? order,
  }) {
    return FavoriteApp(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      order: order ?? this.order,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteApp &&
        other.id == id &&
        other.packageName == packageName &&
        other.order == order;
  }

  @override
  int get hashCode => Object.hash(id, packageName, order);
}
