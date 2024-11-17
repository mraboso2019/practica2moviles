import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'tile.dart';
import 'game_logic.dart';
import 'defeat_screen.dart';
import 'options_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late GameLogic gameLogic;
  int score = 0;
  int moves = 0;
  final int gridSize = 5; // Tamaño de la cuadrícula de 5x5
  final double outerPadding = 16.0; // Margen alrededor de la cuadrícula
  final double innerMargin = 5.0; // Espacio entre cada casilla
  Map<String, double> tilePositions =
      {}; // Guardamos las posiciones de cada tile para animación
  late double tileSize; // Moveremos el cálculo de `tileSize`

  @override
  void initState() {
    super.initState();
    gameLogic = GameLogic();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cálculo seguro de `tileSize` en `didChangeDependencies` donde `MediaQuery` está disponible
    double screenWidth = MediaQuery.of(context).size.width;
    double gridSizePx = screenWidth - 16.0 * 2;
    tileSize = (gridSizePx / 5) - 8;

    //tileSize = (gridSizePx - (innerMargin * (gridSize - 1))) / gridSize;

    initializeTilePositions(); // Inicializar posiciones de los tiles
  }

  void initializeTilePositions() {
    // Inicializar posiciones de todos los tiles en sus posiciones originales (fuera de la cuadrícula)
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        tilePositions["$i-$j"] = -tileSize; // Fuera de la cuadrícula
      }
    }
  }

  void onColumnTap(int column) {
    setState(() {
      bool placed = gameLogic.placeNumberInColumn(column);
      if (placed) {
        applyGravity(); // Aplica la gravedad después de colocar la ficha
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Columna llena. Elige otra columna")),
        );
      }
      if (gameLogic.gameOver) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DefeatScreen()),
        );
      }
    });
  }

  void onSwipe(String direction) {
    setState(() {
      if (direction == "left") {
        // Movimiento hacia la izquierda
        for (int i = 0; i < gridSize; i++) {
          moveAndCombine(gameLogic.tileGrid[i]);
        }
      } else if (direction == "right") {
        // Movimiento hacia la derecha
        for (int i = 0; i < gridSize; i++) {
          List<Tile> reversedRow = gameLogic.tileGrid[i].reversed.toList();
          moveAndCombine(reversedRow);
          gameLogic.tileGrid[i] = reversedRow.reversed.toList();
        }
      }
      applyGravity(); // Aplicamos gravedad después del swipe
    });
  }

  void moveAndCombine(List<Tile> line) {
    int targetIndex = 0;
    for (int currentIndex = 0; currentIndex < gridSize; currentIndex++) {
      Tile currentTile = line[currentIndex];
      if (currentTile.value == 0) continue;

      if (targetIndex > 0 && line[targetIndex - 1].value == currentTile.value) {
        line[targetIndex - 1].value *= 2;
        currentTile.value = 0;
      } else {
        if (targetIndex != currentIndex) {
          line[targetIndex].value = currentTile.value;
          currentTile.value = 0;
        }
        targetIndex++;
      }
    }
  }

  void applyGravity() {
    for (int col = 0; col < gridSize; col++) {
      bool
          didCombine; // Indicador para repetir la columna si se produjo una combinación
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
          // Verificar si podemos combinar
          if (row > 0 &&
              gameLogic.tileGrid[row][col].value ==
                  gameLogic.tileGrid[row - 1][col].value &&
              gameLogic.tileGrid[row][col].value != 0) {
            gameLogic.tileGrid[row][col].value *= 2;
            gameLogic.tileGrid[row - 1][col].value = 0;
            didCombine = true; // Marcamos que hubo una combinación
          }
        }
      } while (
          didCombine); // Repetimos mientras se sigan produciendo combinaciones
    }
    setState(() {}); // Actualizamos la interfaz para reflejar los cambios
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridSizePx = MediaQuery.of(context).size.width - outerPadding * 2;
    double tilePadding = 4.0;
    tileSize = ((gridSizePx - (tilePadding * 5) - 28) / 5);

    List<Widget> stackItems = [];

    // Renderizar el tablero de números en 5x5 con animación de caída
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        Tile tile = gameLogic.tileGrid[i][j];
        String key = "$i-$j"; // Clave única para cada tile en la cuadrícula
        double finalTop = tilePositions[key] ??
            -tileSize; // Posición inicial (fuera de la cuadrícula)

        stackItems.add(
          AnimatedPositioned(
              // Duración de la animación
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              left: j * (tileSize + tilePadding * 2) + tilePadding,
              top: i * (tileSize + tilePadding * 2) + tilePadding,
              // Posición actual de la ficha
              width: tileSize,
              height: tileSize,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    onSwipe("right"); // Swipe a la derecha
                  } else if (details.delta.dx < 0) {
                    onSwipe("left"); // Swipe a la izquierda
                  }
                },
                child: Container(
                  width: tileSize - 8,
                  height: tileSize - 8,
                  decoration: BoxDecoration(
                    color: numTileColor[tile.value] ?? Colors.grey,
                    //color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      tile.value == 0 ? "" : tile.value.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: tile.value != null && tile.value! <= 32
                            ? Colors
                                .pink[900] // Color si la condición es verdadera
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
        );
      }
    }

    // Mostrar el próximo número en la parte superior
    Widget nextNumberDisplay = Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            width: gridSizePx,
            height: tileSize + tilePadding * 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: tileSize,
            height: tileSize,
            decoration: BoxDecoration(
              color: numTileColor[gameLogic.nextNumber],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                gameLogic.nextNumber?.toString() ?? '',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: gameLogic.nextNumber != null &&
                          gameLogic.nextNumber! <= 32
                      ? Colors.pink[900] // Color si la condición es verdadera
                      : Colors.white, // Color si la condición es falsa
                ),
              ),
            ),
          ),
        ),
      ],
    );

    Widget showScore = Container(
      width: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
        children: [
          Text(
            'SCORE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15, // Tamaño de letra más pequeño
              fontWeight: FontWeight.w400, // Peso de fuente más ligero
            ),
          ),
          SizedBox(height: 4), // Separación entre los textos
          Text(
            '$score',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20, // Tamaño de letra más grande
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    Widget showMoves = Container(
      width: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
        children: [
          Text(
            'MOVES',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15, // Tamaño de letra más pequeño
              fontWeight: FontWeight.w400, // Peso de fuente más ligero
            ),
          ),
          SizedBox(height: 4), // Separación entre los textos
          Text(
            '$moves',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20, // Tamaño de letra más grande
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    Widget options = ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OptionsScreen()),
        );
      },
      child: Icon(Icons.menu_rounded),
    );

    return Scaffold(
      //appBar: AppBar(title: Text('Partida en curso')),
      body: Stack(
        children: [
          Positioned(
              top: MediaQuery.of(context).size.height / 12,
              left: outerPadding,
              child: options),
          //showScore,
          //showMoves,
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
            //padding: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showScore,
                SizedBox(width: 20.0),
                showMoves,
                SizedBox(width: outerPadding),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Centrar verticalmente
              children: [
                // Caja del próximo número
                nextNumberDisplay,
                SizedBox(height: 20.0),
                // Caja de la cuadrícula
                Container(
                  width: gridSizePx,
                  height: gridSizePx,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: softGreyPink,
                  ),
                  child: Stack(children: stackItems),
                ),
                SizedBox(height: 20.0),
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
                              //Icons.arrow_downward_rounded,
                              Icons.keyboard_double_arrow_down_rounded,
                              size: 32, // Tamaño del ícono
                              color: Colors.pink[900], // Color del ícono
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
