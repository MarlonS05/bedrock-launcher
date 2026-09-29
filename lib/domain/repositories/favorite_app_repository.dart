import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/exceptions/invalid_favorite_order_exception.dart';

abstract class FavoriteAppRepository {
  /// Returns favorites sorted by [FavoriteApp.order] ascending.
  Future<List<FavoriteApp>> getAll();

  Future<FavoriteApp?> findByPackageName(String packageName);

  /// Appends [packageName] at the end of the favorites list.
  Future<FavoriteApp> add(String packageName);

  Future<void> remove(String packageName);

  /// Replaces display order using the given package names (index = order).
  ///
  /// [packageNamesInOrder] must contain each current favorite exactly once.
  /// Throws [InvalidFavoriteOrderException] when the list is incomplete,
  /// contains duplicates, or includes unknown package names.
  Future<void> reorder(List<String> packageNamesInOrder);
}
