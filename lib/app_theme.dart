import 'package:flutter/material.dart';

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);

const Map<int, Color> numTileColor = {
  0: palePink,                          // Para valor 0, color gris suave
  2: Color.fromARGB(255, 255, 192, 203),    // Rosa claro para valores bajos
  4: Color.fromARGB(255, 255, 182, 193),    // Otro tono rosado claro
  8: Color.fromARGB(255, 255, 174, 185),    // Rosado más saturado
  16: Color.fromARGB(255, 255, 160, 180),   // Rosado suave intermedio
  32: Color.fromARGB(255, 255, 130, 180),   // Rosado algo más fuerte
  64: Color.fromARGB(255, 255, 110, 160),   // Rosado fuerte pero aún suave
  128: Color.fromARGB(255, 240, 85, 140),   // Rosa con más saturación, pero no tan intenso
  256: Color.fromARGB(255, 220, 60, 120),   // Rosa algo más oscuro, manteniendo la suavidad
  512: Color.fromARGB(255, 200, 40, 100),   // Fucsia suave
  1024: Color.fromARGB(255, 180, 30, 90),   // Morado rosado más fuerte
  2048: Color.fromARGB(255, 160, 20, 80),   // Rosa chicle muy intenso, pero sin ser tan agresivo
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
