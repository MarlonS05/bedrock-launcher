import 'package:bedrock_launcher/db/daos/restricted_app_dao.dart';
import 'package:bedrock_launcher/domain/entities/restricted_app.dart';
import 'package:bedrock_launcher/domain/repositories/restricted_app_repository.dart';
import 'package:sqflite/sqflite.dart';

class RestrictedAppRepositoryImpl implements RestrictedAppRepository {
  RestrictedAppRepositoryImpl(Database database)
      : _dao = RestrictedAppDao(database);

  final RestrictedAppDao _dao;

  @override
  Future<List<RestrictedApp>> getAll() => _dao.getAll();

  @override
  Future<void> replaceAll(Set<String> packageNames) {
    return _dao.replaceAll(packageNames);
  }
}
