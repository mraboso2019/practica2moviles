import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necesario para SystemChrome
import 'package:practica_2/music_state.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

// Función principal que ejecuta la app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloquear la orientación en modo retrato
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Inicializar el estado de MusicState antes de ejecutar la app
  final musicState = MusicState();
  await musicState
      .startMusicIfNeeded(); // Comienza la música si está habilitada

  runApp(MyApp(musicState: musicState));
}

class MyApp extends StatelessWidget {
  final MusicState musicState;

  const MyApp({required this.musicState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider<MusicState>.value(value: musicState),
      ],
      child: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return MaterialApp(
            title: 'Merge Down',
            theme: appTheme.currentTheme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
