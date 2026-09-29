import 'package:bedrock_launcher/domain/services/launcher_settings_port.dart';
import 'package:flutter/services.dart';

class AndroidLauncherSettingsAdapter implements LauncherSettingsPort {
  static const _channel =
      MethodChannel('com.example.bedrock_launcher/launcher_settings');

  @override
  Future<void> openDefaultLauncherSettings() async {
    try {
      await _channel.invokeMethod<void>('openHomeSettings');
    } on MissingPluginException {
      throw Exception(
        'Home app settings are unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to open home app settings');
    }
  }
}
