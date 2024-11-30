import 'dart:math';
import 'tile.dart';

class GameLogic {
  // Cuadrícula del juego como lista de listas de Tiles
  List<List<Tile>> tileGrid = [];

  // Tamaño de la cuadrícula (5x5)
  int gridSize = 5;

  // Próximo número a colocar en la cuadrícula
  int? nextNumber;

  // Indica si el juego ha terminado
  bool gameOver = false;

  // Constructor que inicializa la cuadrícula y genera el primer número
  GameLogic() {
    initializeGrid();
    generateNextNumber();
  }

  // Método para inicializar la cuadrícula
  void initializeGrid() {
    // Aseguramos que la cuadrícula sea de 5x5
    tileGrid = List.generate(
      gridSize,
      // Cada casilla comienza con valor 0
      (i) => List.generate(gridSize, (j) => Tile(x: i, y: j, value: 0)),
    );
    print(
        "Grid initialized with dimensions: ${tileGrid.length}x${tileGrid[0].length}");
    printGrid(); // Imprimimos el estado inicial de la cuadrícula para verificar
  }

  // Método para generar un número aleatorio
  void generateNextNumber() {
    // Números posibles para el juego
    List<int> possibleNumbers = [2, 4, 8];
    nextNumber = possibleNumbers[Random().nextInt(possibleNumbers.length)];
    print("Generated next number: $nextNumber");
  }

  // Método para intentar colocar el número actual en una columna
  bool placeNumberInColumn(int column) {
    if (nextNumber == null)
      // Si no hay un número generado, no se puede colocar
      return false;

// Itera desde la fila inferior hacia arriba buscando una posición vacía
    for (int row = gridSize - 1; row >= 0; row--) {
      if (tileGrid[row][column].value == 0) {
        // Coloca el número en la posición vacía
        tileGrid[row][column].value = nextNumber!;
        print("Placed $nextNumber in row $row, column $column");
        // Imprimimos el estado de la cuadrícula después de cada colocación
        printGrid();
        // Genera un nuevo número para la próxima colocación
        generateNextNumber();
        return true;
      }
    }

    // Verifica si la cuadrícula está llena después del intento
    isGridFull();
    // Si no hay posiciones vacías en la columna, muestra un mensaje y retorna falso    print("Column $column is full. Could not place $nextNumber");
    return false;
  }

  // Método para verificar si la cuadrícula está llena
  bool isGridFull() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (tileGrid[row][col].value == 0) {
          // Si encuentra una casilla vacía, la cuadrícula no está llena
          return false;
        }
      }
    }
    // Verifica si hay movimientos posibles
    gameOver = possibleMoves();
    // Retorna true si la cuadrícula está llena
    return true;
  }

  // Método para verificar si existen movimientos válidos en la cuadrícula
  bool possibleMoves() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        int value = tileGrid[row][col].value;

        // Verifica si hay un vecino a la derecha con el mismo valor
        if (col < gridSize - 1 && tileGrid[row][col + 1].value == value) {
          // Hay un movimiento posible
          return false;
        }

        // Verifica si hay un vecino abajo con el mismo valor
        if (row < gridSize - 1 && tileGrid[row + 1][col].value == value) {
          // Hay un movimiento posible
          return false;
        }

        // Verifica si hay un vecino a la izquierda con el mismo valor
        if (col > 0 && tileGrid[row][col - 1].value == value) {
          // Hay un movimiento posible
          return false;
        }

        // Verifica si hay un vecino arriba con el mismo valor
        if (row > 0 && tileGrid[row - 1][col].value == value) {
          // Hay un movimiento posible
          return false;
        }
      }
    }
    return true;
  }

  // Método para imprimir el estado actual de la cuadrícula (para depuración)
  void printGrid() {
    for (var row in tileGrid) {
      print(row.map((tile) => tile.value).toList());
    }
    print("----------");
  }
}
