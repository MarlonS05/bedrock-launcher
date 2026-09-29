package com.example.bedrock_launcher

import android.content.Context
import android.content.Intent
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LauncherSettingsHandler(private val context: Context) :
    MethodChannel.MethodCallHandler {
    companion object {
        const val CHANNEL = "com.example.bedrock_launcher/launcher_settings"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "openHomeSettings" -> {
                try {
                    val intent = Intent(Settings.ACTION_HOME_SETTINGS)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    context.startActivity(intent)
                    result.success(null)
                } catch (error: Exception) {
                    result.error("UNAVAILABLE", error.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }
}
