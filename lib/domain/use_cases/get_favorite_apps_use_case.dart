import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';

class GetFavoriteAppsUseCase {
  const GetFavoriteAppsUseCase(this._repository);

  final FavoriteAppRepository _repository;

  /// Returns favorites sorted by display order ascending.
  Future<List<FavoriteApp>> call() => _repository.getAll();
}
