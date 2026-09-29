import 'package:bedrock_launcher/domain/services/system_apps_port.dart';
import 'package:flutter/services.dart';

class AndroidSystemAppsAdapter implements SystemAppsPort {
  static const _channel =
      MethodChannel('com.example.bedrock_launcher/system_apps');

  @override
  Future<void> openDialer() async {
    try {
      final opened = await _channel.invokeMethod<bool>('openDialer');
      if (opened != true) {
        throw Exception('No dialer app is available on this device.');
      }
    } on MissingPluginException {
      throw Exception(
        'Dialer is unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to open dialer');
    }
  }

  @override
  Future<void> openCamera() async {
    try {
      final opened = await _channel.invokeMethod<bool>('openCamera');
      if (opened != true) {
        throw Exception('No camera app is available on this device.');
      }
    } on MissingPluginException {
      throw Exception(
        'Camera is unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to open camera');
    }
  }

  @override
  Future<void> openGallery() async {
    try {
      final opened = await _channel.invokeMethod<bool>('openGallery');
      if (opened != true) {
        throw Exception('No gallery app is available on this device.');
      }
    } on MissingPluginException {
      throw Exception(
        'Gallery is unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to open gallery');
    }
  }

  @override
  Future<void> openClock() async {
    try {
      final opened = await _channel.invokeMethod<bool>('openClock');
      if (opened != true) {
        throw Exception('No clock app is available on this device.');
      }
    } on MissingPluginException {
      throw Exception(
        'Clock is unavailable. Stop the app and run '
        '`flutter run` again to rebuild native code.',
      );
    } on PlatformException catch (error) {
      throw Exception(error.message ?? 'Failed to open clock');
    }
  }
}
