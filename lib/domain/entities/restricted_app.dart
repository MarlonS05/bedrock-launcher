/// An app that must pass a math hurdle before launch.
///
/// Existence of a row with [packageName] means the app is restricted.
class RestrictedApp {
  const RestrictedApp({required this.packageName});

  /// Android package name (e.g. `com.example.app`).
  final String packageName;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RestrictedApp && other.packageName == packageName;
  }

  @override
  int get hashCode => packageName.hashCode;
}
