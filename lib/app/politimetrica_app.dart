import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_routes.dart';

class PolitiMetricaApp extends StatelessWidget {
  const PolitiMetricaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PolitiMetrica Ecuador',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}