import 'package:flutter/material.dart';
import 'package:practica_2/game_screen.dart';
import 'package:practica_2/home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class DefeatScreen extends StatelessWidget {
  final int score;
  final int moves;

  DefeatScreen({required this.score, required this.moves});

  @override
  Widget build(BuildContext context) {
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;
    final numTileColor = Provider.of<AppTheme>(context).numTileColor;

    return Scaffold(
      body: Container(
        decoration: gradientDecoration,
        child: Center(
          child: Stack(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('GAME OVER',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('TOTAL MOVES',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: numTileColor[2],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(' $moves',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('FINAL SCORE',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: numTileColor[2],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(' $score',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 2, 40),
                      ),
                      child: Text('MENU'),
                    ),
                    const Spacer(flex: 1),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 2, 40),
                      ),
                      child: Text('NEW GAME'),
                    ),
                    const Spacer(flex: 20),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
