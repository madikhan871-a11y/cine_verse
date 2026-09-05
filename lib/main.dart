import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CineVerseApp());
}

class CineVerseApp extends StatelessWidget {
  const CineVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: AppConstants.appName,

      theme: AppTheme.darkTheme,

      home: const SplashScreen(),
    );
  }
}