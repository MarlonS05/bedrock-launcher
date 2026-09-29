/// Path-keyed deny-lists for bedrockLauncher layer import boundaries.
///
/// Must stay in sync with [docs/architecture.md] and
/// [test/architecture/layer_import_test.dart].
class LayerImportRules {
  LayerImportRules._();

  static const packagePrefix = 'package:bedrock_launcher/';

  static const domainDeny = [
    'package:flutter/',
    '${packagePrefix}screens/',
    '${packagePrefix}repo/',
    '${packagePrefix}db/',
    '${packagePrefix}platform/',
    '${packagePrefix}router/',
    '${packagePrefix}di/',
    '${packagePrefix}theme/',
    'package:flutter_bloc/',
    'package:go_router/',
  ];

  static const repoDeny = [
    'package:flutter/',
    '${packagePrefix}screens/',
    '${packagePrefix}router/',
    '${packagePrefix}di/',
    'package:flutter_bloc/',
  ];

  static const dbDeny = [
    'package:flutter/',
    '${packagePrefix}screens/',
    '${packagePrefix}repo/',
    '${packagePrefix}router/',
    '${packagePrefix}di/',
    'package:flutter_bloc/',
  ];

  static const platformDeny = [
    '${packagePrefix}screens/',
    '${packagePrefix}repo/',
    '${packagePrefix}db/',
    '${packagePrefix}router/',
    '${packagePrefix}di/',
    'package:flutter_bloc/',
  ];

  static const viewDeny = [
    '${packagePrefix}repo/',
    '${packagePrefix}db/',
    '${packagePrefix}router/',
    '${packagePrefix}di/',
    'package:go_router/',
  ];

  static const blocDeny = [
    '${packagePrefix}repo/',
    '${packagePrefix}db/',
    'package:go_router/',
    'package:sqflite/',
  ];

  static const componentDeny = [
    '${packagePrefix}repo/',
    '${packagePrefix}db/',
    '${packagePrefix}router/',
    '${packagePrefix}di/',
    'package:flutter_bloc/',
    'package:go_router/',
  ];

  static List<String> denialsForFile(String path) {
    final normalized = path.replaceAll('\\', '/');

    if (normalized.contains('/lib/domain/')) {
      return domainDeny;
    }
    if (normalized.contains('/lib/repo/')) {
      return repoDeny;
    }
    if (normalized.contains('/lib/db/')) {
      return dbDeny;
    }
    if (normalized.contains('/lib/platform/')) {
      return platformDeny;
    }
    if (normalized.contains('/lib/screens/components/')) {
      return componentDeny;
    }

    final fileName = normalized.split('/').last;
    if (_endsWithSuffix(fileName, '_view.')) {
      return viewDeny;
    }
    if (_endsWithSuffix(fileName, '_bloc.') ||
        _endsWithSuffix(fileName, '_event.') ||
        _endsWithSuffix(fileName, '_state.')) {
      return blocDeny;
    }

    return const [];
  }

  static bool importMatchesDenial(String uri, String prefix) {
    if (prefix.endsWith('/')) {
      return uri.startsWith(prefix);
    }
    return uri == prefix || uri.startsWith('$prefix/');
  }

  static bool _endsWithSuffix(String fileName, String suffix) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex <= 0) {
      return false;
    }
    return fileName.substring(0, dotIndex + 1).endsWith(suffix);
  }
}
