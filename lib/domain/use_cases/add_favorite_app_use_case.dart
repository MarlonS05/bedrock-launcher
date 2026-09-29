import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';

class AddFavoriteAppUseCase {
  const AddFavoriteAppUseCase(this._repository);

  final FavoriteAppRepository _repository;

  Future<FavoriteApp> call(String packageName) {
    return _repository.add(packageName);
  }
}
