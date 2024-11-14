import 'package:flutter/material.dart';

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);

void main() {
  runApp(MyApp());
}

class Tile {
  final int x;
  final int y;
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
  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width - 16.0 * 2;
    double tileSize = (gridSize - 4.0 * 2) / 5;
    List<Widget> stackItems = [];

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
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
                  color: palePink,
                  borderRadius: BorderRadius.circular(8.0),
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
      body: Center(
        child: Container(
          width: gridSize,
          height: gridSize,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: softGreyPink),
          child: Stack(
            children: stackItems,
          ),
        ),
      ),
    );
  }
}
