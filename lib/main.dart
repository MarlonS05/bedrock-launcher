import 'dart:async';

import 'package:bedrock_launcher/di/di.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  unawaited(getIt<ListInstalledAppsUseCase>()());
  runApp(const BedrockLauncherApp());
}

class BedrockLauncherApp extends StatelessWidget {
  const BedrockLauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'bedrockLauncher',
      theme: AppTheme.light,
      routerConfig: getIt<GoRouter>(),
    );
  }
}
