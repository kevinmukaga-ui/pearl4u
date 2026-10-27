import 'package:flutter/material.dart';
import 'screens/auth/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const Pearl4UApp());
}

class Pearl4UApp extends StatelessWidget {
  const Pearl4UApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pearl4U - Discover Uganda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}
