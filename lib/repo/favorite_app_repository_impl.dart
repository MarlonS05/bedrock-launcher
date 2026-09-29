import 'package:bedrock_launcher/db/daos/favorite_app_dao.dart';
import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/exceptions/invalid_favorite_order_exception.dart';
import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteAppRepositoryImpl implements FavoriteAppRepository {
  FavoriteAppRepositoryImpl(Database database)
      : _dao = FavoriteAppDao(database);

  final FavoriteAppDao _dao;

  @override
  Future<List<FavoriteApp>> getAll() => _dao.getAllOrdered();

  @override
  Future<FavoriteApp?> findByPackageName(String packageName) {
    return _dao.findByPackageName(packageName);
  }

  @override
  Future<FavoriteApp> add(String packageName) async {
    final existing = await _dao.findByPackageName(packageName);
    if (existing != null) {
      return existing;
    }

    final order = await _dao.nextDisplayOrder();
    return _dao.insert(packageName: packageName, displayOrder: order);
  }

  @override
  Future<void> remove(String packageName) {
    return _dao.deleteByPackageName(packageName);
  }

  @override
  Future<void> reorder(List<String> packageNamesInOrder) async {
    final current = await _dao.getAllOrdered();
    final currentNames = current.map((favorite) => favorite.packageName).toSet();

    if (packageNamesInOrder.length != currentNames.length) {
      throw InvalidFavoriteOrderException(
        'Expected ${currentNames.length} package names but received '
        '${packageNamesInOrder.length}.',
      );
    }

    if (packageNamesInOrder.toSet().length != packageNamesInOrder.length) {
      throw const InvalidFavoriteOrderException(
        'Package names must not contain duplicates.',
      );
    }

    for (final packageName in packageNamesInOrder) {
      if (!currentNames.contains(packageName)) {
        throw InvalidFavoriteOrderException(
          'Unknown favorite package name: $packageName.',
        );
      }
    }

    final orderByPackageName = <String, int>{
      for (var i = 0; i < packageNamesInOrder.length; i++)
        packageNamesInOrder[i]: i,
    };
    await _dao.updateDisplayOrders(orderByPackageName);
  }
}
