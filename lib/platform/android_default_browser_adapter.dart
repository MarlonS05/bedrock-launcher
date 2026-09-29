import 'package:bedrock_launcher/domain/services/default_browser_port.dart';
import 'package:flutter/services.dart';

class AndroidDefaultBrowserAdapter implements DefaultBrowserPort {
  static const _channel =
      MethodChannel('com.example.bedrock_launcher/default_browser');

  @override
  Future<void> openDefaultBrowser() async {
    try {
      final opened = await _channel.invokeMethod<bool>('openDefaultBrowser');
      if (opened != true) {
        throw Exception('No default browser is available on this device.');
      }
    } on MissingPluginException {
      throw Exception(
        'Default browser is unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to open default browser');
    }
  }
}
