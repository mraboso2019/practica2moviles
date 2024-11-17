import 'dart:math';
import 'tile.dart';
import 'defeat_screen.dart';

class GameLogic {
  List<List<Tile>> tileGrid = [];
  int gridSize = 5; // Tamaño de la cuadrícula (5x5)
  int? nextNumber;
  bool gameOver = false;// El próximo número a colocar

  GameLogic() {
    initializeGrid();
    generateNextNumber();
  }

  void initializeGrid() {
    // Aseguramos que la cuadrícula sea de 5x5
    tileGrid = List.generate(
      gridSize,
      (i) => List.generate(gridSize, (j) => Tile(x: i, y: j, value: 0)),
    );
    print(
        "Grid initialized with dimensions: ${tileGrid.length}x${tileGrid[0].length}");
    printGrid(); // Imprimimos el estado inicial de la cuadrícula para verificar
  }

  void generateNextNumber() {
    List<int> possibleNumbers = [2, 4, 8];
    nextNumber = possibleNumbers[Random().nextInt(possibleNumbers.length)];
    print("Generated next number: $nextNumber");
  }

  bool placeNumberInColumn(int column) {
    if (nextNumber == null)
      return false; // Verifica que haya un número a colocar

    // Empezamos desde la fila inferior y colocamos el número en la primera posición vacía
    for (int row = gridSize - 1; row >= 0; row--) {
      if (tileGrid[row][column].value == 0) {
        tileGrid[row][column].value = nextNumber!;
        print("Placed $nextNumber in row $row, column $column");
        printGrid(); // Imprimimos el estado de la cuadrícula después de cada colocación
        generateNextNumber(); // Genera un nuevo número para la próxima colocación
        return true;
      }
    }

    isGridfull();
    // Si llega aquí, significa que la columna está llena
    print("Column $column is full. Could not place $nextNumber");
    return false;
  }

  bool isGridfull() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (tileGrid[row][col].value == 0) {
          return false; // Si hay al menos una casilla vacía, no está llena
        }
      }
    }
    gameOver = possibleMoves();
    return true;
  }

  bool possibleMoves(){
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        int value = tileGrid[row][col].value;

        if (col < gridSize - 1 && tileGrid[row][col + 1].value == value) {
          return false; // Hay un movimiento posible
        }

        // Verificar vecino de abajo (si no está en el borde inferior)
        if (row < gridSize - 1 && tileGrid[row + 1][col].value == value) {
          return false; // Hay un movimiento posible
        }

        // Verificar vecino de la izquierda (si no está en el borde izquierdo)
        if (col > 0 && tileGrid[row][col - 1].value == value) {
          return false; // Hay un movimiento posible
        }

        // Verificar vecino de arriba (si no está en el borde superior)
        if (row > 0 && tileGrid[row - 1][col].value == value) {
          return false; // Hay un movimiento posible
        }
      }
    }
    return true;
  }

  void swipeLeft() {
    for (int i = 0; i < gridSize; i++) {
      List<Tile> row = tileGrid[i];
      List<int> newRow = [];

      for (var tile in row) {
        if (tile.value != 0) newRow.add(tile.value);
      }

      for (int j = 0; j < gridSize; j++) {
        row[j].value = (j < newRow.length) ? newRow[j] : 0;
      }
    }
    print("Swiped left");
    printGrid(); // Imprimimos el estado de la cuadrícula después de cada swipe
  }

  // Función para imprimir el estado actual de la cuadrícula (para depuración)
  void printGrid() {
    for (var row in tileGrid) {
      print(row.map((tile) => tile.value).toList());
    }
    print("----------");
  }
}
