/// A device-installed font face discoverable for launcher app labels.
class InstalledFont {
  const InstalledFont({
    required this.familyId,
    required this.label,
    required this.path,
    this.ttcIndex = 0,
  });

  /// Key used as the Flutter font family after the face is loaded.
  final String familyId;

  /// Human-readable name shown in Appearance settings.
  final String label;

  /// Absolute path to the `.ttf` / `.otf` / `.ttc` file on device.
  final String path;

  /// Index within a TrueType Collection (`.ttc`), when applicable.
  final int ttcIndex;
}
