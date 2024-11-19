import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'background_music.dart';  // Este es tu archivo donde manejas la música
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    // Reproducir la música de fondo en bucle al iniciar la app
    _assetsAudioPlayer.open(
      Audio("assets/music/background_music.mp3"), // Ruta al archivo de audio
       // Hace que la música se repita
      autoStart: true, // Comienza a reproducir automáticamente
    );
    _assetsAudioPlayer.setLoopMode(LoopMode.single);
  }

  @override
  void dispose() {
    // Detenemos la música al cerrar la app
    _assetsAudioPlayer.stop();
    super.dispose();
  }

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
