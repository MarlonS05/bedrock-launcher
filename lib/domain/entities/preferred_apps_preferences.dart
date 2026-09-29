/// User-configurable preferred apps for home-screen shortcuts.
class PreferredAppsPreferences {
  const PreferredAppsPreferences({
    this.clockPackageName,
    this.phonePackageName,
    this.cameraPackageName,
    this.galleryPackageName,
  });

  /// Package name for the clock app, or null for system default.
  final String? clockPackageName;

  /// Package name for the phone/dialer app, or null for system default.
  final String? phonePackageName;

  /// Package name for the camera app, or null for system default.
  final String? cameraPackageName;

  /// Package name for the gallery app, or null for system default.
  final String? galleryPackageName;

  static const defaults = PreferredAppsPreferences();

  PreferredAppsPreferences copyWith({
    String? clockPackageName,
    String? phonePackageName,
    String? cameraPackageName,
    String? galleryPackageName,
    bool clearClockPackageName = false,
    bool clearPhonePackageName = false,
    bool clearCameraPackageName = false,
    bool clearGalleryPackageName = false,
  }) {
    return PreferredAppsPreferences(
      clockPackageName: clearClockPackageName
          ? null
          : (clockPackageName ?? this.clockPackageName),
      phonePackageName: clearPhonePackageName
          ? null
          : (phonePackageName ?? this.phonePackageName),
      cameraPackageName: clearCameraPackageName
          ? null
          : (cameraPackageName ?? this.cameraPackageName),
      galleryPackageName: clearGalleryPackageName
          ? null
          : (galleryPackageName ?? this.galleryPackageName),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PreferredAppsPreferences &&
        other.clockPackageName == clockPackageName &&
        other.phonePackageName == phonePackageName &&
        other.cameraPackageName == cameraPackageName &&
        other.galleryPackageName == galleryPackageName;
  }

  @override
  int get hashCode => Object.hash(
        clockPackageName,
        phonePackageName,
        cameraPackageName,
        galleryPackageName,
      );
}
