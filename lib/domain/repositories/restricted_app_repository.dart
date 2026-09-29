import 'package:bedrock_launcher/domain/entities/restricted_app.dart';

abstract class RestrictedAppRepository {
  /// Returns all restricted apps ordered by package name.
  Future<List<RestrictedApp>> getAll();

  /// Replaces the full restricted-app set with [packageNames].
  Future<void> replaceAll(Set<String> packageNames);
}
