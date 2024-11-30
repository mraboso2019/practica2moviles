// Definición de la clase Tile, que representa una las fichas tablero
class Tile {
  // Coordenada 'x' de la casilla en la matriz (posición horizontal)
  final int x;
  // Coordenada 'y' de la casilla en la matriz (posición vertical)
  final int y;
  // Valor de la ficha
  int value;

  // Constructor de la clase Tile, donde se proporcionan valores para x, y y value
  // 'required' asegura que los parámetros proporcionados al crear una instancia de Tile
  Tile({required this.x, required this.y, required this.value});
}
