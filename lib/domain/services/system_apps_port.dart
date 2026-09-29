abstract interface class SystemAppsPort {
  Future<void> openDialer();

  Future<void> openCamera();

  Future<void> openGallery();

  Future<void> openClock();
}
