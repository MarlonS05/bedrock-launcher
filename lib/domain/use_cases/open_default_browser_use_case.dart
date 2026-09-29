import 'package:bedrock_launcher/domain/services/default_browser_port.dart';

class OpenDefaultBrowserUseCase {
  const OpenDefaultBrowserUseCase(this._defaultBrowserPort);

  final DefaultBrowserPort _defaultBrowserPort;

  Future<void> call() => _defaultBrowserPort.openDefaultBrowser();
}
