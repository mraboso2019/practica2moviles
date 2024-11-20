import 'package:flutter/material.dart';
import 'package:practica_2/music_test.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

  // Este es tu archivo donde manejas la música

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppTheme>(
      create: (_) => AppTheme(),
      child: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return MaterialApp(
            title: '2048',
            theme: appTheme.currentTheme, // Usa el tema actual
            home: HomeScreen(), // Pantalla inicial de la app
          );
        },
      ),
    );
  }
}
