import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'tile.dart';
import 'game_logic.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late GameLogic gameLogic;
  final int gridSize = 5; // Tamaño de la cuadrícula de 5x5
  final double outerMargin = 16.0; // Margen alrededor de la cuadrícula
  final double innerMargin = 4.0; // Espacio entre cada casilla
  Map<String, double> tilePositions = {}; // Guardamos las posiciones de cada tile para animación
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
    double gridSizePx = screenWidth - 2 * outerMargin;
    tileSize = (gridSizePx - (innerMargin * (gridSize - 1))) / gridSize;

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
        // Actualizamos las posiciones en `tilePositions` para cada fila y columna de la cuadrícula
        for (int row = gridSize - 1; row >= 0; row--) {
          Tile tile = gameLogic.tileGrid[row][column];
          if (tile.value != 0) {
            tilePositions["$row-$column"] = row * tileSize + innerMargin * row;
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Columna llena. Elige otra columna")),
        );
      }
    });
  }

  void onSwipe(Tile tile, int dx, int dy) {
    int newX = tile.x + dx;
    int newY = tile.y + dy;

    // Verifica que la nueva posición esté dentro de los límites de la cuadrícula
    if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridSize) {
      Tile targetTile = gameLogic.tileGrid[newX][newY];

      setState(() {
        // Verifica si la ficha adyacente tiene el mismo valor para combinarla
        if (targetTile.value == tile.value && tile.value != 0) {
          targetTile.value *= 2; // Combina las fichas
          tile.value = 0; // Borra el valor de la ficha original
        } else if (targetTile.value == 0) {
          // Mueve la ficha a la posición vacía
          targetTile.value = tile.value;
          tile.value = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridSizePx = screenWidth - 2 * outerMargin;
    double containerHeight = gridSizePx;

    List<Widget> stackItems = [];

    // Fondo de la cuadrícula para mostrar las posiciones
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        stackItems.add(
          Positioned(
            left: j * (tileSize + innerMargin),
            top: i * (tileSize + innerMargin),
            width: tileSize,
            height: tileSize,
            child: Container(
              decoration: BoxDecoration(
                color: palePink, // Color suave para el fondo de la cuadrícula
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        );
      }
    }

    // Renderizar el tablero de números en 5x5 con animación de caída
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        Tile tile = gameLogic.tileGrid[i][j];
        String key = "$i-$j"; // Clave única para cada tile en la cuadrícula
        double finalTop = tilePositions[key] ?? -tileSize; // Posición inicial (fuera de la cuadrícula)

        stackItems.add(
          AnimatedPositioned(
            duration: Duration(milliseconds: 300), // Duración de la animación
            curve: Curves.easeOut, // Suavizado de la animación
            left: j * (tileSize + innerMargin),
            top: finalTop,
            width: tileSize,
            height: tileSize,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  onSwipe(tile, 0, 1); // Swipe a la derecha
                } else if (details.delta.dx < 0) {
                  onSwipe(tile, 0, -1); // Swipe a la izquierda
                }
              },
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  onSwipe(tile, 1, 0); // Swipe hacia abajo
                } else if (details.delta.dy < 0) {
                  onSwipe(tile, -1, 0); // Swipe hacia arriba
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: numTileColor[tile.value] ?? Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    tile.value == 0 ? "" : tile.value.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    // Mostrar el próximo número en la parte superior
    Widget nextNumberDisplay = Container(
      width: gridSizePx,
      height: tileSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          gameLogic.nextNumber?.toString() ?? '',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Partida en curso')),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          nextNumberDisplay, // Muestra el próximo número
          SizedBox(height: 10.0),
          Container(
            width: gridSizePx + 2 * outerMargin,
            height: containerHeight + 2 * outerMargin,
            padding: EdgeInsets.all(outerMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: softGreyPink,
            ),
            child: Stack(children: stackItems),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(gridSize, (index) {
              return GestureDetector(
                onTap: () => onColumnTap(index),
                child: Container(
                  width: tileSize,
                  height: tileSize / 2,
                  color: Colors.transparent,
                  child: Center(
                    child: Text("↓", style: TextStyle(fontSize: 24, color: Colors.black)),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
