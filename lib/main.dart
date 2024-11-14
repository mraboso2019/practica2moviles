import 'package:flutter/material.dart';

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);

const Map<int, Color> numTileColor = {
  0: palePink,
  2: Color.fromARGB(255, 255, 192, 203),      // Rosa claro para valores bajos
  4: Color.fromARGB(255, 255, 182, 193),      // Otro tono rosado claro
  8: Color.fromARGB(255, 255, 174, 185),      // Rosado más saturado
  16: Color.fromARGB(255, 255, 140, 170),     // Rosado intermedio
  32: Color.fromARGB(255, 255, 105, 180),     // Rosado fuerte
  64: Color.fromARGB(255, 255, 20, 147),      // Rosado intenso
  128: Color.fromARGB(255, 219, 112, 147),    // Rosa viejo
  256: Color.fromARGB(255, 219, 82, 129),     // Rosa más oscuro
  512: Color.fromARGB(255, 199, 21, 133),     // Fucsia fuerte
  1024: Color.fromARGB(255, 186, 85, 211),    // Morado rosado
  2048: Color.fromARGB(255, 255, 0, 127),     // Rosa chicle muy intenso
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
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameScreen()),
              );
            },
            child: Text('Comenzar Partida')),
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
  void initState(){
    super.initState();
    initializeGrid();
  }

  void initializeGrid(){
    int numRows = 5;
    tileGrid = List.generate(numRows, (i) =>
    List.generate(numRows, (j) => Tile(x: i, y: j, value: 0)));

    tileGrid[1][2].value = 4;
    tileGrid[3][2].value = 16;
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
              ),
            ),
          ),
        );
      }}


    return Scaffold(
      appBar: AppBar(
        title: Text('Partida en curso'),
      ),
      body: Center(
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
                  borderRadius: BorderRadius.circular(8.0), color: softGreyPink),
              child: Stack(
                children: stackItems,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
