import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necesario para SystemChrome
import 'package:practica_2/music_state.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

// Función principal que ejecuta la app
void main() async {
  // Asegura que los Widgets de flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Bloquear la orientación en modo retrato
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Inicializar el estado de MusicState antes de ejecutar la app
  final musicState = MusicState();
  // Comienza la música si está habilitada
  await musicState.startMusicIfNeeded();

  // Llama a la clase principal de la app pasando el estado de música como argumento
  runApp(MyApp(musicState: musicState));
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  // Recibe el estado de la música como argumento
  final MusicState musicState;

  // Constructor para inicializar `musicState`
  const MyApp({required this.musicState});

  @override
  Widget build(BuildContext context) {
    // Permite gestionar múltiples estados de la app al mismo tiempo
    return MultiProvider(
      providers: [
        // Proveedor para gestionar el tema de la app
        ChangeNotifierProvider(create: (_) => AppTheme()),
        // Proveedor para gestionar el estado de la música
        ChangeNotifierProvider<MusicState>.value(value: musicState),
      ],
      // Consumer escucha cambios en el tema y actualiza la interfaz cuando sea necesario
      child: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return MaterialApp(
            // Título de la app
            title: 'Merge Down',
            // Aplica el tema actual
            theme: appTheme.currentTheme,
            // Define la pantalla inicial como 'HomeScreen'
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
