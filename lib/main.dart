import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}
