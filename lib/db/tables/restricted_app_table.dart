/// Schema for apps that require a math hurdle before launch.
abstract final class RestrictedAppTable {
  static const name = 'restricted_apps';

  static const columnPackageName = 'package_name';

  /// Used in Migration 6
  static const create = '''
CREATE TABLE $name (
  $columnPackageName TEXT PRIMARY KEY
)
''';
}
