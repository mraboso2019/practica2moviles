import 'package:flutter/material.dart';
import 'package:practica_2/game_screen.dart';
import 'package:practica_2/home_screen.dart';

class DefeatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You lost :(',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
                child: Text('MENU'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
                ),
                child: Text('NEW GAME'),
              ),
            ]),
      ),
    );
  }
}
