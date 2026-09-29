package com.example.bedrock_launcher

import android.content.Context
import android.content.Intent
import android.net.Uri
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DefaultBrowserHandler(private val context: Context) : MethodChannel.MethodCallHandler {
    companion object {
        const val CHANNEL = "com.example.bedrock_launcher/default_browser"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "openDefaultBrowser" -> result.success(openDefaultBrowser())
            else -> result.notImplemented()
        }
    }

    private fun openDefaultBrowser(): Boolean {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse("http://")).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (intent.resolveActivity(context.packageManager) == null) {
            return false
        }

        context.startActivity(intent)
        return true
    }
}
