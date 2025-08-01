import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'config/router/router.dart';
import 'config/theme/app_theme.dart';
import 'core/services/services_cache.dart';

void main() async{

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  // Initialize CacheService
  await CacheService().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gestor de Tareas Avanzado',
      theme: AppThemes.lightTheme,
      routerConfig: router,
    );
  }
}

