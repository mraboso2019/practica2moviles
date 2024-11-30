import 'package:flutter/material.dart';
import 'package:practica_2/game_screen.dart';
import 'package:practica_2/how_to_play.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'settings.dart';

class PauseGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gradientDecoration = Provider.of<AppTheme>(context).gradientBackground;
    return Scaffold(
      body: Container(
        decoration: gradientDecoration,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('RESUME'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  // Mostrar la alerta al usuario
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm New Game'), // Título de la alerta
                        content: Text('Are you sure you want to start a new game?'), // Mensaje
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo sin hacer nada
                            },
                            child: Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo
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
                child: Text('NEW GAME'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
                child: Text('SETTINGS'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HowToPlay()),
                  );
                },
                child: Text('HOW TO PLAY'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
              ),
              const Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
}
