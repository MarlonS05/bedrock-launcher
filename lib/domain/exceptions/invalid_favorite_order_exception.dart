/// Thrown when [FavoriteAppRepository.reorder] receives an invalid package list.
class InvalidFavoriteOrderException implements Exception {
  const InvalidFavoriteOrderException(this.message);

  final String message;

  @override
  String toString() => 'InvalidFavoriteOrderException: $message';
}
