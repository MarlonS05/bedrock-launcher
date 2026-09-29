package com.example.bedrock_launcher

import android.content.Context
import android.content.Intent
import android.provider.AlarmClock
import android.provider.MediaStore
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SystemAppsHandler(private val context: Context) : MethodChannel.MethodCallHandler {
    companion object {
        const val CHANNEL = "com.example.bedrock_launcher/system_apps"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "openDialer" -> result.success(openDialer())
            "openCamera" -> result.success(openCamera())
            "openGallery" -> result.success(openGallery())
            "openClock" -> result.success(openClock())
            else -> result.notImplemented()
        }
    }

    private fun openDialer(): Boolean {
        val intent = Intent(Intent.ACTION_DIAL).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (intent.resolveActivity(context.packageManager) == null) {
            return false
        }

        context.startActivity(intent)
        return true
    }

    private fun openCamera(): Boolean {
        val intent = Intent(MediaStore.INTENT_ACTION_STILL_IMAGE_CAMERA).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (intent.resolveActivity(context.packageManager) == null) {
            return false
        }

        context.startActivity(intent)
        return true
    }

    private fun openGallery(): Boolean {
        val galleryIntent = Intent(Intent.ACTION_MAIN).apply {
            addCategory(Intent.CATEGORY_APP_GALLERY)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (galleryIntent.resolveActivity(context.packageManager) != null) {
            context.startActivity(galleryIntent)
            return true
        }

        val fallbackIntent = Intent(Intent.ACTION_VIEW).apply {
            type = "image/*"
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (fallbackIntent.resolveActivity(context.packageManager) == null) {
            return false
        }

        context.startActivity(fallbackIntent)
        return true
    }

    private fun openClock(): Boolean {
        val intent = Intent(AlarmClock.ACTION_SHOW_ALARMS).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (intent.resolveActivity(context.packageManager) == null) {
            return false
        }

        context.startActivity(intent)
        return true
    }
}
