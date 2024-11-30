import 'package:flutter/material.dart';
import 'package:practica_2/game_screen.dart';
import 'package:practica_2/how_to_play.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'settings.dart';

class PauseGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene el decorador de gradiente para el estado del tema actual
    final gradientDecoration = Provider.of<AppTheme>(context).gradientBackground;
    return Scaffold(
      body: Container(
        // Aplica el fondo con gradiente
        decoration: gradientDecoration,
        child: Center(
          child: Column(
            // Centra el contenido verticalmente
            mainAxisSize: MainAxisSize.min,
            children: [
              // Agrega espacio proporcional en la parte superior
              const Spacer(flex: 20),
              // Botón para volver al juego
              ElevatedButton(
                // Cierra la pantalla actual
                onPressed: () {
                  Navigator.pop(context);
                },
                // Texto del botón
                child: Text('RESUME'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              // Espaciador entre botones
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  // Muestra un cuadro de diálogo para confirmar si se inicia un nuevo juego
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Título de la alerta
                      return AlertDialog(
                        title: Text('CONFIRM NEW GAME'),
                        // Mensaje
                        content: Text('Are you sure you want to start a new game?'), // Mensaje
                        actions: [
                          // Botón para cancelar
                          TextButton(
                            onPressed: () {
                              // Cierra el cuadro de diálogo
                              Navigator.pop(context); // Cierra el diálogo sin hacer nada
                            },
                            child: Text('CANCEL'),
                          ),
                          // Botón para iniciar nueva partida
                          TextButton(
                            onPressed: () {
                              // Cierra el diálogo
                              Navigator.pop(context);
                              // Navega a una nueva pantalla de juego
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GameScreen()), // Navega a la pantalla de juego
                              );
                            },
                            child: Text('START'),
                          ),
                        ],
                      );
                    },
                  );
                },
                // Texto del botón
                child: Text('NEW GAME'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              // Espaciador entre diálogos
              const Spacer(flex: 1),
              // Botón para abrir ajustes
              ElevatedButton(
                onPressed: () {
                  // Navega a pantalla de Settings
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
                // Texto del botón
                child: Text('SETTINGS'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              // Espaciador entre botones
              const Spacer(flex: 1),
              // Botón para ver cómo jugar
              ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de How To Play
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HowToPlay()),
                  );
                },
                // Texto del botón
                child: Text('HOW TO PLAY'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              // Espaciador proporcional a la parte inferior
              const Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
}
