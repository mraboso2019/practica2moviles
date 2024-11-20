import 'package:flutter/material.dart';
import 'package:practica_2/music_state.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => MusicState()),
      ],
      child: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          Future.delayed(Duration.zero, () {
            // Iniciar la música cuando la app se haya cargado
            Provider.of<MusicState>(context, listen: false).startMusic();
          });
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
