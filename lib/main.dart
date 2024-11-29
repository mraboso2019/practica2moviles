import 'package:flutter/material.dart';
import 'package:practica_2/game_screen.dart';
import 'package:practica_2/how_to_play.dart';
import 'package:practica_2/music_state.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'settings.dart';
import 'package:provider/provider.dart';
import 'pause_game.dart';
import 'defeat_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => MusicState()), // Aquí creas el MusicState
      ],
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
