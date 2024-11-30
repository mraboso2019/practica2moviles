import 'package:flutter/material.dart';
import 'package:practica_2/music_state.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

// Función donde se ejecuta la app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Multiprovider permite proveer varios estados a la aplicación
    return MultiProvider(
      providers: [
        // Proveedor que gestiona el estado del tema de la app
        ChangeNotifierProvider(create: (_) => AppTheme()),
        // Proveedor que estiona el estado de la música y efectos de sonido
        ChangeNotifierProvider(create: (_) => MusicState()),
      ],
      // Consumer escucha los cambios en el estado del tema y reconstruye el widget cuando cambia
      child: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return MaterialApp(
            // Título de la app
            title: 'Merge Down',
            // Tema de la app
            theme: appTheme.currentTheme,
            // Pantalla inicial de la app
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
