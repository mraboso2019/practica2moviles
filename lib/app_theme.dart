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
  // More colors...
};

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: lightPink,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: softGreyPink,
      textStyle: TextStyle(fontSize: 20),
    ),
  ),
);
