class LauncherApp {
  const LauncherApp({
    required this.packageName,
    required this.displayName,
    this.isRestricted = false,
  });

  final String packageName;
  final String displayName;
  final bool isRestricted;

  LauncherApp copyWith({
    String? packageName,
    String? displayName,
    bool? isRestricted,
  }) {
    return LauncherApp(
      packageName: packageName ?? this.packageName,
      displayName: displayName ?? this.displayName,
      isRestricted: isRestricted ?? this.isRestricted,
    );
  }
}
