package com.example.bedrock_launcher

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, LauncherSettingsHandler.CHANNEL)
            .setMethodCallHandler(LauncherSettingsHandler(this))

        MethodChannel(messenger, DefaultBrowserHandler.CHANNEL)
            .setMethodCallHandler(DefaultBrowserHandler(this))

        MethodChannel(messenger, BatteryHandler.CHANNEL)
            .setMethodCallHandler(BatteryHandler(this))

        MethodChannel(messenger, SystemAppsHandler.CHANNEL)
            .setMethodCallHandler(SystemAppsHandler(this))

        MethodChannel(messenger, SystemFontsHandler.CHANNEL)
            .setMethodCallHandler(SystemFontsHandler())
    }
}
