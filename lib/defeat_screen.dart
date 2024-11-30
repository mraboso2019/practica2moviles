import 'package:flutter/material.dart';
import 'package:practica_2/game_screen.dart';
import 'package:practica_2/home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class DefeatScreen extends StatelessWidget {
  // Puntaje final obtenido por el jugador
  final int score;

  // Número total de movimientos realizados por el jugador
  final int moves;

  // Constructor para recibir puntaje y movimientos como parámetros requeridos
  DefeatScreen({required this.score, required this.moves});

  @override
  Widget build(BuildContext context) {
    // Obtiene el gradiente de fondo y color de los tiles del tema actual usando Provider
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;
    final numTileColor = Provider.of<AppTheme>(context).numTileColor;

    return Scaffold(
      // Contenedor principal con el fondo degradado
      body: Container(
        decoration: gradientDecoration,
        child: Center(
          child: Stack(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Espacio inicial superior
                    const Spacer(flex: 20),
                    // Contenedor para mostrar el mensaje "GAME OVER"
                    Container(
                      // 75% del ancho de la pantalla
                      width: MediaQuery.of(context).size.width * 0.75,
                      // Espaciado interno
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Texto del mensaje
                          Text('GAME OVER',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                    // Espaciado entre secciones
                    const Spacer(flex: 1),
                    // Contenedor para mostrar los movimientos totales
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          // Espaciado interno
                          SizedBox(
                            height: 10,
                          ),
                          Text('TOTAL MOVES',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              // Color del fondo del número
                              color: numTileColor[2],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Muestra el número total de movimientos
                                Text(' $moves',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    // Espaciado entre secciones
                    const Spacer(flex: 1),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('FINAL SCORE',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: numTileColor[2],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Muestra el puntaje final
                                Text(' $score',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    // Espaciado entre secciones
                    const Spacer(flex: 1),
                    // Botón para volver al menú principal
                    ElevatedButton(
                      onPressed: () {
                        // Navega a la pantalla principal
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 2, 40),
                      ),
                      child: Text('MENU'),
                    ),
                    // Espaciado entre botones
                    const Spacer(flex: 1),
                    // Botón para comenzar un nuevo juego
                    ElevatedButton(
                      onPressed: () {
                        // Navega a la pantalla del juego
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 2, 40),
                      ),
                      // Texto del botón
                      child: Text('NEW GAME'),
                    ),
                    // Espaciado final inferior
                    const Spacer(flex: 20),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
