import 'package:bedrock_launcher/domain/services/battery_port.dart';
import 'package:flutter/services.dart';

class AndroidBatteryAdapter implements BatteryPort {
  static const _channel = MethodChannel('com.example.bedrock_launcher/battery');

  @override
  Future<int> getBatteryLevel() async {
    try {
      final level = await _channel.invokeMethod<int>('getBatteryLevel');
      if (level == null || level < 0 || level > 100) {
        throw Exception('Invalid battery level returned from platform.');
      }
      return level;
    } on MissingPluginException {
      throw Exception(
        'Battery level is unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to read battery level');
    }
  }
}
