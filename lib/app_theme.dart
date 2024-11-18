import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  bool _isPinkTheme = false;

  bool get isPinkTheme => _isPinkTheme;

  void toggleTheme() {
    _isPinkTheme = !_isPinkTheme;
    notifyListeners(); // Notifica a los widgets que dependen de este estado
  }

  // Proporciona el tema actual según el estado
  ThemeData get currentTheme {
    return _isPinkTheme ? pinkTheme : purpleTheme;
  }
}

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);
const Color purplePink = Color(0xFF3D2C3B);

const Color lightPurple = Color.fromARGB(255, 220, 198, 245);
const Color darkPurple = Color.fromARGB(255, 153, 102, 204);
const Color palePurple = Color.fromARGB(255, 240, 224, 250);
const Color softGreyPurple = Color.fromARGB(255, 175, 138, 191);
const Color deepPurple = Color(0xFF4A235A);

const Map<int, Color> numTileColor = {
  0: Colors.white,
  //2: Color.fromARGB(255, 255, 192, 203),
  2: palePink,
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
  4096: Color.fromARGB(255, 140, 10, 70),
  8192: Color.fromARGB(255, 120, 5, 60),
};

const Map<int, Color> numTileDarkColors = {
  0: Colors.white,
  2: lightPurple,
  4: Color.fromARGB(255, 175, 138, 191),
  8: Color.fromARGB(255, 153, 102, 204),
  16: Color.fromARGB(255, 140, 80, 200),
  32: Color.fromARGB(255, 130, 60, 180),
  64: Color.fromARGB(255, 120, 50, 160),
  128: Color.fromARGB(255, 110, 40, 140),
  256: Color.fromARGB(255, 100, 30, 120),
  512: Color.fromARGB(255, 90, 20, 100),
  1024: Color.fromARGB(255, 80, 10, 90),
  2048: Color.fromARGB(255, 70, 5, 80),
  4096: Color.fromARGB(255, 60, 5, 70),
  8192: Color.fromARGB(255, 50, 5, 60),
};

ThemeData get pinkTheme => ThemeData(
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: lightPink,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.pink[900]),
        bodyMedium: TextStyle(color: Colors.pink[900]),
        bodySmall: TextStyle(color: Colors.pink[900]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink[900],
          textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.pink[900],
        size: 32,
      ),
    );

ThemeData get purpleTheme => ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: lightPurple,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.purple[900]),
        bodyMedium: TextStyle(color: Colors.purple[900]),
        bodySmall: TextStyle(color: Colors.purple[900]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple[900],
          textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.purple[900],
        size: 32,
      ),
    );
