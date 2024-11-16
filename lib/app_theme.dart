import 'package:flutter/material.dart';

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);
const Color purplePink = Color(0xFF3D2C3B);

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

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: lightPink,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.pink[900],
      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    ),
  ),
);
