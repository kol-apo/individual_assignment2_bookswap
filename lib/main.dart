import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/auth/splash_screen.dart';

void main() {
  runApp(const BookSwapApp());
}

class BookSwapApp extends StatelessWidget {
  const BookSwapApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookSwap',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
