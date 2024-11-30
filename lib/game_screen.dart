import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme.dart';
import 'tile.dart';
import 'game_logic.dart';
import 'defeat_screen.dart';
import 'pause_game.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'music_state.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  // Instancia de la lógica del juego
  late GameLogic gameLogic;

  // Puntuación del jugador
  int score = 0;

  // Número de movimientos realizados
  int moves = 0;

  // Tamaño de la cuadrícula (5x5)
  final int gridSize = 5;

  // Margen alrededor de la cuadrícula
  final double outerPadding = 16.0;

  // Espacio entre cada casilla
  final double innerMargin = 5.0;

  // Mapa para guardar las posiciones de cada casilla (para animaciones)
  Map<String, double> tilePositions = {};

  // Tamaño de cada casilla calculado dinámicamente
  late double tileSize;

  @override
  void initState() {
    super.initState();
    // Inicializamos la lógica del juego
    gameLogic = GameLogic();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Calculamos el tamaño de las casillas de manera dinámica según el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double gridSizePx = screenWidth - 16.0 * 2;
    tileSize = (gridSizePx / 5) - 8;

    // Inicializamos las posiciones de los tiles (fuera de la cuadrícula)
    initializeTilePositions();
  }

  void initializeTilePositions() {
    // Inicializar posiciones de todos los tiles en sus posiciones originales (fuera de la cuadrícula)
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        // Fuera de la cuadrícula
        tilePositions["$i-$j"] = -tileSize;
      }
    }
  }

  // Lógica cuando el jugador toca una columna para colocar un número
  void onColumnTap(int column) {
    final musicState = Provider.of<MusicState>(context, listen: false);
    setState(() {
      bool placed = gameLogic.placeNumberInColumn(column);
      if (placed) {
        // Incrementamos el contador de movimientos
        moves++;
        // Reproducimos sonido de toque
        musicState.tapSound();
        // Aplica gravedad para ajustar las fichas
        applyGravity();
      } else {
        // Si la columna está llena, mostramos un mensaje al jugador
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Full column. Choose another one.")),
        );
      }
      // Si el juego ha terminado, navegamos a la pantalla de derrota
      if (gameLogic.gameOver) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DefeatScreen(
              score: score,
              moves: moves,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  // Lógica para manejar el deslizamiento (swipe) hacia izquierda o derecha
  void onSwipe(String direction) {
    final musicState = Provider.of<MusicState>(context, listen: false);
    setState(() {
      // Indicador para detectar cambios en el tablero
      bool hasChanged = false;

      if (direction == "left") {
        // Movimiento hacia la izquierda
        for (int i = 0; i < gridSize; i++) {
          if (moveAndCombine(gameLogic.tileGrid[i])) {
            hasChanged = true;
          }
        }
      } else if (direction == "right") {
        // Movimiento hacia la derecha
        for (int i = 0; i < gridSize; i++) {
          List<Tile> reversedRow = gameLogic.tileGrid[i].reversed.toList();
          if (moveAndCombine(reversedRow)) {
            hasChanged = true;
          }
          gameLogic.tileGrid[i] = reversedRow.reversed.toList();
        }
      }

      if (hasChanged) {
        // Incrementamos movimientos si hubo cambios
        moves++;
        // Reproducimos sonido de swipe
        musicState.swipeSound();
        // Aplicamos gravedad después del swipe
        applyGravity();
      }
    });
  }

  bool moveAndCombine(List<Tile> line) {
    // Combina y mueve las fichas en una fila o columna
    bool hasChanged = false;
    int targetIndex = 0;

    for (int currentIndex = 0; currentIndex < gridSize; currentIndex++) {
      Tile currentTile = line[currentIndex];
      // Ignoramos fichas vacías
      if (currentTile.value == 0) continue;

      if (targetIndex > 0 && line[targetIndex - 1].value == currentTile.value) {
        // Si las fichas son iguales, las combinamos
        line[targetIndex - 1].value *= 2;
        currentTile.value = 0;
        hasChanged = true;
      } else {
        if (targetIndex != currentIndex) {
          // Movemos la ficha si es necesario
          line[targetIndex].value = currentTile.value;
          currentTile.value = 0;
          hasChanged = true;
        }
        targetIndex++;
      }
    }
    return hasChanged;
  }

  // Aplica la gravedad
  void applyGravity() {
    for (int col = 0; col < gridSize; col++) {
      // Indicador para repetir la columna si se produjo una combinación
      bool didCombine;
      do {
        didCombine = false;
        for (int row = gridSize - 1; row > 0; row--) {
          if (gameLogic.tileGrid[row][col].value == 0) {
            // Si encontramos un espacio vacío, movemos la ficha hacia abajo
            for (int aboveRow = row - 1; aboveRow >= 0; aboveRow--) {
              if (gameLogic.tileGrid[aboveRow][col].value != 0) {
                gameLogic.tileGrid[row][col].value =
                    gameLogic.tileGrid[aboveRow][col].value;
                gameLogic.tileGrid[aboveRow][col].value = 0;
                break;
              }
            }
          }
          // Verificamos si se pueden combinar fichas
          if (row > 0 &&
              gameLogic.tileGrid[row][col].value ==
                  gameLogic.tileGrid[row - 1][col].value &&
              gameLogic.tileGrid[row][col].value != 0) {
            // Combinamos fichas
            gameLogic.tileGrid[row][col].value *= 2;
            // Actualizamos la puntuación
            score += gameLogic.tileGrid[row][col].value;
            gameLogic.tileGrid[row - 1][col].value = 0;
            // Marcamos que hubo una combinación
            didCombine = true;
          }
        }
      } // Repetimos mientras se sigan produciendo combinaciones
      while (didCombine);
    }
    // Actualizamos la interfaz para reflejar los cambios
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Calcula el tamaño del tablero en píxeles basado en el ancho de lapantalla
    double gridSizePx = MediaQuery.of(context).size.width - outerPadding * 2;
    // Espacio entre las fichas
    double tilePadding = 4.0;
    // Tamaño de cada ficha
    tileSize = ((gridSizePx - (tilePadding * 5) - 28) / 5);

    // Colores de las fichas, color de la fuente y el fondo del tablero según el tema actual
    Map<int, Color> numTileColor = Provider.of<AppTheme>(context).numTileColor;
    Color tileFontColor = Provider.of<AppTheme>(context).tileFontColor;
    Color gridBackGroundColor =
        Provider.of<AppTheme>(context).gridBackGroundColor;
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;

    // Lista de widgets que representan las fichas y se mostrarán en un Stack
    List<Widget> stackItems = [];

    // Crear las fichas del tablero en una cuadrícula 5x5
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        // Crear las fichas del tablero en una cuadrícula 5x5
        Tile tile = gameLogic.tileGrid[i][j];
        // Clave única para cada tile en la cuadrícula
        String key = "$i-$j";
        // Posición inicial (fuera de la cuadrícula)
        double finalTop = tilePositions[key] ?? -tileSize;

        stackItems.add(
          // Animación para mover las fichas
          AnimatedPositioned(
              // Duración de la animación
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              // Posición horizontal
              left: j * (tileSize + tilePadding * 2) + tilePadding,
              // Posición vertical
              top: i * (tileSize + tilePadding * 2) + tilePadding,
              // Posición actual de la ficha
              width: tileSize,
              height: tileSize,
              // Detector de gestos
              child: GestureDetector(
                // Detectar arrastres horizontales
                onHorizontalDragUpdate: (details) {
                  // Swipe a la derecha
                  if (details.delta.dx > 0) {
                    onSwipe("right");
                  } // Swipe a la izquierda
                  else if (details.delta.dx < 0) {
                    onSwipe("left");
                  }
                },
                // Contenedor que representa cada ficha
                child: Container(
                  width: tileSize - 8,
                  height: tileSize - 8,
                  decoration: BoxDecoration(
                    // Color basado en el valor de la ficha
                    color: numTileColor[tile.value] ?? Colors.grey,
                    // Color basado en el valor de la ficha
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      // Mostrar el valor si es distinto de 0
                      tile.value == 0 ? "" : tile.value.toString(),
                      // Estilo del texto de la ficha
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: tile.value != null && tile.value! <= 32
                            // Color para fichas pequeñas
                            ? tileFontColor
                            // Color para fichas grandes
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
        );
      }
    }

    // Widget para mostrar el próximo número en la parte superior
    Widget nextNumberDisplay = Stack(
      alignment: Alignment.center,
      children: [
        Center(
          // Contenedor
          child: Container(
            // Mismo tamaño del tablero
            width: gridSizePx,
            // Tamaño de la ficha con un poco de margen
            height: tileSize + tilePadding * 4,
            // Color blanco y bordes redondeados
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        // Centrado
        Align(
          alignment: Alignment.center,
          // Muestra la ficha siguiente
          child: Container(
            // Tamaño de la ficha
            width: tileSize,
            height: tileSize,
            // Color basado en el siguiente número
            decoration: BoxDecoration(
              color: numTileColor[gameLogic.nextNumber],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                gameLogic.nextNumber?.toString() ?? '',
                // Estilo del texto de la ficha
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: gameLogic.nextNumber != null &&
                          gameLogic.nextNumber! <= 32
                      // Color para números pequeños
                      ? tileFontColor
                      // Color para números grandes
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    // Widget para mostrar la puntuación
    Widget showScore = Container(
      width: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        // Ajusta el tamaño al contenido
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SCORE',
            textAlign: TextAlign.center,
            style: TextStyle(
              // Tamaño de letra más pequeño
              fontSize: 15,
              // Peso de fuente más ligero
              fontWeight: FontWeight.w400,
            ),
          ),
          // Separación entre los textos
          SizedBox(height: 4),
          Text(
            '$score',
            textAlign: TextAlign.center,
            style: TextStyle(
              // Tamaño de letra más grande
              fontSize: 20,
              // Peso de la fuente más grande
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    // Widget para mostrar los movimientos
    Widget showMoves = Container(
      width: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        // Ajusta el tamaño al contenido
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'MOVES',
            textAlign: TextAlign.center,
            style: TextStyle(
              // Tamaño de letra más pequeño
              fontSize: 15,
              // Peso de fuente más ligero
              fontWeight: FontWeight.w400,
            ),
          ),
          // Separación entre los textos
          SizedBox(height: 4),
          Text(
            '$moves',
            textAlign: TextAlign.center,
            style: TextStyle(
              // Tamaño de letra más grande
              fontSize: 20,
              // Peso de la fuente más grande
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    // Botón para abrir el menú de pausa
    Widget options = ElevatedButton(
      onPressed: () {
        // Navega al menú de pausa
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PauseGame()),
        );
      },
      child: Icon(Icons.menu_rounded),
    );

    // Estructura principal de la interfaz
    return Scaffold(
      // Fondo con degradado
      body: Container(
        decoration: gradientDecoration,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Espaciador flexible
              const Spacer(flex: 5),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: outerPadding),
                    // Botón de menú
                    options,
                    const Spacer(flex: 10),
                    // Puntuación
                    showScore,
                    const Spacer(flex: 1),
                    // Número de movimientos
                    showMoves,
                    SizedBox(width: outerPadding),
                  ],
                ),
              ),
              // Espacio entre elementos
              const Spacer(flex: 7),
              // Widget que muestra el próximo número
              nextNumberDisplay,
              const Spacer(flex: 5),
              // Tablero
              Container(
                // Tamaño del tablero
                width: gridSizePx,
                height: gridSizePx,
                padding: EdgeInsets.all(4.0),
                // Color y bordes
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: gridBackGroundColor,
                ),
                // Fichas
                child: Stack(children: stackItems),
              ),
              // Espacio entre elementos
              const Spacer(flex: 4),
              // Fila con flechas
              Container(
                width: gridSizePx,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(gridSize, (index) {
                    return GestureDetector(
                      onTap: () => onColumnTap(index),
                      child: Container(
                        width: tileSize,
                        height: tileSize / 1.5,
                        color: Colors.transparent,
                        child: Center(
                          child: Icon(
                            Icons.keyboard_double_arrow_down_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              // Espacio final
              const Spacer(flex: 40),
            ],
          ),
        ),
      ),
    );
  }
}
