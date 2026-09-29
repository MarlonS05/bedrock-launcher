import 'dart:io';

import 'package:bedrock_launcher/domain/entities/installed_font.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:flutter/services.dart';

class AndroidInstalledFontsAdapter implements InstalledFontsPort {
  static const _channel =
      MethodChannel('com.example.bedrock_launcher/installed_fonts');

  final Map<String, InstalledFont> _byId = {};
  final Set<String> _loaded = {};
  List<InstalledFont>? _cachedList;

  @override
  Future<List<InstalledFont>> listFonts() async {
    if (_cachedList != null) {
      return _cachedList!;
    }

    try {
      final raw = await _channel.invokeMethod<List<dynamic>>('listFonts');
      final fonts = <InstalledFont>[];
      for (final entry in raw ?? const []) {
        if (entry is! Map) {
          continue;
        }
        final familyId = entry['familyId'] as String?;
        final label = entry['label'] as String?;
        final path = entry['path'] as String?;
        if (familyId == null ||
            familyId.isEmpty ||
            label == null ||
            path == null) {
          continue;
        }
        final ttcIndex = (entry['ttcIndex'] as num?)?.toInt() ?? 0;
        final font = InstalledFont(
          familyId: familyId,
          label: label,
          path: path,
          ttcIndex: ttcIndex,
        );
        fonts.add(font);
        _byId[familyId] = font;
      }
      _cachedList = fonts;
      return fonts;
    } on MissingPluginException {
      return const [];
    } on PlatformException {
      return const [];
    }
  }

  @override
  Future<void> loadFont(String familyId) async {
    if (familyId == 'system' || _loaded.contains(familyId)) {
      return;
    }

    var font = _byId[familyId];
    if (font == null) {
      await listFonts();
      font = _byId[familyId];
    }
    if (font == null) {
      return;
    }

    final file = File(font.path);
    if (!await file.exists()) {
      return;
    }

    final loader = FontLoader(familyId);
    loader.addFont(
      file.readAsBytes().then((bytes) => ByteData.view(bytes.buffer)),
    );
    await loader.load();
    _loaded.add(familyId);
  }
}
