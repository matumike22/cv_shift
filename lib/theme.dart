import 'package:flutter/material.dart';

class AppTheme {
  ThemeData _theme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      primaryColor: Color(0xFF6750A4),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }

  ThemeData get theme => _theme();
}
