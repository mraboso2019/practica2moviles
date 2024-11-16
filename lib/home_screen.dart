import 'package:flutter/material.dart';
import 'package:practica_2/defeat_screen.dart';
import 'game_screen.dart';
import 'options_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pantalla de Inicio')),
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
              child: Text('Jugar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OptionsScreen()),
                );
              },
              child: Text('Opciones'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
