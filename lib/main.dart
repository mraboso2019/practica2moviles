import 'package:flutter/material.dart';

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);

const Map<int, Color> numTileColor = {
  0: palePink,
  2: Color.fromARGB(255, 255, 192, 203),
  4: Color.fromARGB(255, 255, 182, 193),
  8: Color.fromARGB(255, 255, 174, 185),
  16: Color.fromARGB(255, 255, 160, 180),
  32: Color.fromARGB(255, 255, 130, 180),
  64: Color.fromARGB(255, 255, 110, 160),
  128: Color.fromARGB(255, 240, 85, 140),
  256: Color.fromARGB(255, 220, 60, 120),
  512: Color.fromARGB(255, 200, 40, 100),
  1024: Color.fromARGB(255, 180, 30, 90),
  2048: Color.fromARGB(255, 160, 20, 80),
};

void main() {
  runApp(MyApp());
}

class Tile {
  final int x;
  final int y;

  int value;

  Tile({required this.x, required this.y, required this.value});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: lightPink,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: softGreyPink,
            textStyle: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla de Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                ),
                child: Text('Comenzar Partida')),
            SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Options()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                ),
                child: Text('Opciones')),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<Tile>> tileGrid = [];

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  void initializeGrid() {
    int numRows = 5;
    tileGrid = List.generate(numRows,
        (i) => List.generate(numRows, (j) => Tile(x: i, y: j, value: 0)));

    tileGrid[3][2].value = 4;
    tileGrid[4][2].value = 16;
    tileGrid[4][4].value = 64;
    tileGrid[4][0].value = 256;
  }

  void swipeLeft() {
    for (int i = 0; i < tileGrid.length; i++) {
      List<Tile> row = tileGrid[i];

      List<int> newRow = [];
      for (var tile in row) {
        if (tile.value != 0) {
          newRow.add(tile.value);
        }
      }

      while (newRow.length < row.length) {
        newRow.add(0); // Añadimos ceros a la fila hasta completar el tamaño
      }

      for (int j = 0; j < row.length; j++) {
        row[j].value = newRow[j];
      }
    }
  }

  void onSwipeLeft() {
    setState(() {
      swipeLeft();
    });
  }

  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width - 16.0 * 2;
    double tileSize = (gridSize - 4.0 * 2) / 5;
    List<Widget> stackItems = [];

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        Tile tile = tileGrid[i][j];

        stackItems.add(
          Positioned(
            left: j * tileSize + 4.0,
            // Desplazamos por 4.0 para compensar el margen
            top: i * tileSize + 4.0,
            // Igual que arriba, ajustamos el margen
            width: tileSize - 4.0 * 2,
            // Asegúrate de restar el margen del contenedor
            height: tileSize - 4.0 * 2,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: numTileColor[tile.value],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(tile.value == 0 ? "" : tile.value.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Partida en curso'),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                // Si el swipe fue hacia la izquierda
                onSwipeLeft();
              }
            },
            child: Container(
              width: double.infinity,
              // Hacer que el Container ocupe todo el ancho
              height: double.infinity,
              // Hacer que el Container ocupe toda la altura
              color: Colors
                  .transparent, // Usamos transparente para que sea solo el detector
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: gridSize,
                  height: tileSize,
                  decoration: BoxDecoration(
                    color: softGreyPink, // Color rosado
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: gridSize,
                  height: gridSize,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: softGreyPink),
                  child: Stack(
                    children: stackItems,
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

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones'),
      ),
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}
