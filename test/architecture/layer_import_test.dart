import 'dart:io';

import 'package:bedrock_launcher_lint_rules/layer_import_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lib/ files respect layer import boundaries', () {
    final libDir = Directory('lib');
    expect(
      libDir.existsSync(),
      isTrue,
      reason: 'Expected lib/ directory at ${libDir.path}',
    );

    final violations = <String>[];

    for (final entity in libDir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }

      final denials = LayerImportRules.denialsForFile(entity.path);
      if (denials.isEmpty) {
        continue;
      }

      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].trim();
        final uri = _extractImportUri(line);
        if (uri == null) {
          continue;
        }

        for (final denial in denials) {
          if (LayerImportRules.importMatchesDenial(uri, denial)) {
            violations.add('${entity.path}:${i + 1}: $line');
          }
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Layer import violations:\n${violations.join('\n')}',
    );
  });
}

String? _extractImportUri(String line) {
  if (!line.startsWith('import ') && !line.startsWith('export ')) {
    return null;
  }

  final quoteStart = line.indexOf("'");
  final doubleQuoteStart = line.indexOf('"');
  final start = quoteStart == -1
      ? doubleQuoteStart
      : doubleQuoteStart == -1
      ? quoteStart
      : quoteStart < doubleQuoteStart
      ? quoteStart
      : doubleQuoteStart;

  if (start == -1) {
    return null;
  }

  final quote = line[start];
  final end = line.indexOf(quote, start + 1);
  if (end == -1) {
    return null;
  }

  return line.substring(start + 1, end);
}
