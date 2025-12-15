import 'package:flutter/material.dart';
import 'package:loom_cv/theme.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoomCV',
      theme: AppTheme().theme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
