package com.example.bedrock_launcher

import android.graphics.fonts.Font
import android.graphics.fonts.SystemFonts
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.Locale

class SystemFontsHandler : MethodChannel.MethodCallHandler {
    companion object {
        const val CHANNEL = "com.example.bedrock_launcher/installed_fonts"

        private val WEIGHT_SUFFIXES = listOf(
            "thin",
            "extralight",
            "ultralight",
            "light",
            "regular",
            "medium",
            "semibold",
            "demibold",
            "bold",
            "extrabold",
            "ultrabold",
            "black",
            "heavy",
            "italic",
            "oblique",
            "condensed",
            "expanded",
        )
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "listFonts" -> {
                try {
                    result.success(listFonts())
                } catch (error: Exception) {
                    result.error(
                        "LIST_FONTS_FAILED",
                        error.message ?: "Failed to list fonts",
                        null,
                    )
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun listFonts(): List<Map<String, Any>> {
        val candidates = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            listFromSystemFontsApi()
        } else {
            listFromFontDirectories()
        }

        val bestByFamily = linkedMapOf<String, FontCandidate>()
        for (candidate in candidates) {
            if (shouldSkip(candidate.fileName)) {
                continue
            }
            val existing = bestByFamily[candidate.familyId]
            if (existing == null || candidate.score > existing.score) {
                bestByFamily[candidate.familyId] = candidate
            }
        }

        return bestByFamily.values
            .sortedBy { it.label.lowercase(Locale.US) }
            .map { it.toMap() }
    }

    private fun listFromSystemFontsApi(): List<FontCandidate> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            return emptyList()
        }

        val fonts: Set<Font> = SystemFonts.getAvailableFonts()
        return fonts.mapNotNull { font ->
            val file = font.file ?: return@mapNotNull null
            if (!file.isFile || !file.canRead()) {
                return@mapNotNull null
            }
            val fileName = file.name
            val familyId = familyIdFromFileName(fileName)
            FontCandidate(
                familyId = familyId,
                label = familyId,
                path = file.absolutePath,
                ttcIndex = font.ttcIndex,
                score = faceScore(fileName, font.style.weight),
                fileName = fileName,
            )
        }
    }

    private fun listFromFontDirectories(): List<FontCandidate> {
        val directories = listOf(
            File("/system/fonts"),
            File("/product/fonts"),
            File("/system/product/fonts"),
        )
        val results = mutableListOf<FontCandidate>()
        for (directory in directories) {
            if (!directory.isDirectory || !directory.canRead()) {
                continue
            }
            val files = directory.listFiles() ?: continue
            for (file in files) {
                if (!file.isFile || !file.canRead()) {
                    continue
                }
                val lower = file.name.lowercase(Locale.US)
                if (!lower.endsWith(".ttf") &&
                    !lower.endsWith(".otf") &&
                    !lower.endsWith(".ttc")
                ) {
                    continue
                }
                val familyId = familyIdFromFileName(file.name)
                results.add(
                    FontCandidate(
                        familyId = familyId,
                        label = familyId,
                        path = file.absolutePath,
                        ttcIndex = 0,
                        score = faceScore(file.name, weight = 400),
                        fileName = file.name,
                    ),
                )
            }
        }
        return results
    }

    private fun shouldSkip(fileName: String): Boolean {
        val lower = fileName.lowercase(Locale.US)
        return lower.contains("emoji") ||
            lower.contains("coloremoji") ||
            lower.contains("color-emoji")
    }

    private fun familyIdFromFileName(fileName: String): String {
        var base = fileName
        val dot = base.lastIndexOf('.')
        if (dot > 0) {
            base = base.substring(0, dot)
        }
        val parts = base.split('-', '_', ' ')
            .filter { it.isNotBlank() }
            .toMutableList()
        while (parts.size > 1) {
            val last = parts.last().lowercase(Locale.US)
            if (WEIGHT_SUFFIXES.contains(last) || last.toIntOrNull() != null) {
                parts.removeAt(parts.lastIndex)
            } else {
                break
            }
        }
        return parts.joinToString(" ").ifBlank { base }
    }

    private fun faceScore(fileName: String, weight: Int): Int {
        val lower = fileName.lowercase(Locale.US)
        var score = 0
        if (lower.contains("regular") || lower.contains("-rg")) {
            score += 100
        }
        if (!lower.contains("italic") && !lower.contains("oblique")) {
            score += 40
        }
        score += 40 - kotlin.math.abs(weight - 400) / 10
        return score
    }

    private data class FontCandidate(
        val familyId: String,
        val label: String,
        val path: String,
        val ttcIndex: Int,
        val score: Int,
        val fileName: String,
    ) {
        fun toMap(): Map<String, Any> = mapOf(
            "familyId" to familyId,
            "label" to label,
            "path" to path,
            "ttcIndex" to ttcIndex,
        )
    }
}
