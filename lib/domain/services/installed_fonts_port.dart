import 'package:bedrock_launcher/domain/entities/installed_font.dart';

/// Discovers and loads device-installed fonts for launcher typography.
abstract interface class InstalledFontsPort {
  /// Returns unique font families available on the device (sorted by label).
  Future<List<InstalledFont>> listFonts();

  /// Registers [familyId] with the rendering engine so app labels can use it.
  /// No-op for `system` or already-loaded families.
  Future<void> loadFont(String familyId);
}
