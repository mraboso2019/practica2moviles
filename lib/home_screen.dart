import 'package:flutter/material.dart';
import 'package:practica_2/how_to_play.dart';
import 'package:practica_2/settings.dart';
import 'game_screen.dart';
import 'package:animations/animations.dart';
import 'app_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene la decoración del fondo degradado del proveedor 'AppTheme'
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;

    // Estructura de la interfaz de usuario
    return Scaffold(
      body: Container(
        // Aplica la decoración de fondo (gradiente)
        decoration: gradientDecoration,
        // Columna para organizar widgets en vertical
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Espacio en la parte superior de la pantalla
            const Spacer(flex: 20),
            // Desplaza el logo 20 píxeles hacia la izquierda
            Transform.translate(
              offset: Offset(-20, 0),
              // Carga y muestra el logo del juego
              child: Image.asset("assets/Logo.png"),
            ),
            // Botón para iniciar el juego
            ElevatedButton(
              onPressed: () {
                // Navega a la pantalla del juego (GameScreen)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GameScreen(),
                  ),
                );
              },
              // Texto del botón
              child: Text('START'),
              // Tamaño del botón
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            // Espacio de separación entre los botones
            const Spacer(flex: 1),
            // Botón para entrar a los ajustes
            ElevatedButton(
              onPressed: () {
                // Navega a la pantalla de configuración
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
              // Texto del botón
              child: Text('SETTINGS'),
              // Tamaño del botón
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            // Espacio de separación entre los botones
            const Spacer(flex: 1),
            // Botón para entrar a la pantalla de cómo jugar
            ElevatedButton(
              onPressed: () {
                // Navega a la pantalla de instrucciones (HowToPlay)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HowToPlay(),
                  ),
                );
              },
              // Texto del botón
              child: Text('HOW TO PLAY'),
              // Tamaño del botón
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            // Espacio entre la parte inferior de la pantalla
            const Spacer(flex: 20),
          ],
        ),
      ),
    );
  }
}
