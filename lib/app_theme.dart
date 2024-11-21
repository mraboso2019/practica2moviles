import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  int _currentThemeIndex = 0;

  int get currentThemeIndex => _currentThemeIndex;
  ThemeData _currentTheme = pinkTheme;

  ThemeData get currentTheme => _currentTheme;

  Map<int, Color> numTileColor = pinkTileColors;
  Color tileFontColor = Colors.pink[900]!;
  Color gridBackGroundColor = softGreyPink;
  Color backgroundColor = lightPink;

  AppTheme() {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _currentThemeIndex =
        prefs.getInt('currentThemeIndex') ?? 0; // 0 es el valor por defecto
    _applyTheme(_currentThemeIndex);
    print(_currentTheme);
  }

  void _saveTheme(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentThemeIndex', themeIndex);
  }

  void _applyTheme(int themeIndex) {
    switch (themeIndex) {
      case 0:
        setPinkTheme();
        break;
      case 1:
        setBlueTheme();
        break;
      case 2:
        setPurpleTheme();
        break;
      default:
        setPinkTheme(); // Tema por defecto
    }
    notifyListeners();
    print(_currentTheme);
  }

  void setPinkTheme() {
    _currentTheme = pinkTheme;
    tileFontColor = Colors.pink[900]!;
    numTileColor = pinkTileColors;
    gridBackGroundColor = softGreyPink;
    backgroundColor = lightPink;
  }

  void setPurpleTheme() {
    _currentTheme = purpleTheme;
    tileFontColor = Colors.white;
    numTileColor = purpleTileColors;
    gridBackGroundColor = softGreyPurple;
    backgroundColor = lightPurple;
  }

  void setBlueTheme() {
    _currentTheme = blueTheme;
    tileFontColor = Colors.blue[900]!;
    numTileColor = blueGreenTileColors;
    gridBackGroundColor = softGreyBlue;
    backgroundColor = lightBlueGreen;
  }

  void changeTheme(int themeIndex) async {
    _currentThemeIndex = themeIndex;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentThemeIndex', themeIndex); // Guardar el índice del tema

    _applyTheme(_currentThemeIndex);
    _saveTheme(_currentThemeIndex);
  }

  BoxDecoration get gradientBackground => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gridBackGroundColor,
            backgroundColor,
            gridBackGroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
}

const Color lightPink = Color.fromARGB(255, 255, 182, 193);
const Color darkPink = Color.fromARGB(255, 255, 105, 180);
const Color palePink = Color.fromARGB(255, 255, 228, 225);
const Color softGreyPink = Color.fromARGB(255, 219, 112, 147);
const Color purplePink = Color(0xFF3D2C3B);

const Color lightPurple = Color.fromARGB(255, 215, 178, 253);
const Color darkPurple = Color.fromARGB(255, 153, 102, 204);
const Color palePurple = Color.fromARGB(255, 240, 224, 250);
const Color softGreyPurple = Color.fromARGB(255, 141, 94, 156);
const Color deepPurple = Color(0xFF4A235A);

const Color lightBlueGreen = Color.fromARGB(255, 173, 216, 230);
const Color mediumBlueGreen = Color.fromARGB(255, 85, 185, 228);
const Color darkBlueGreen = Color.fromARGB(255, 60, 170, 200);
const Color softGreyBlue = Color.fromARGB(255, 94, 114, 156);
const Color deepBlueGreen = Color.fromARGB(255, 30, 100, 150);

const Map<int, Color> pinkTileColors = {
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

const Map<int, Color> purpleTileColors = {
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

const Map<int, Color> blueGreenTileColors = {
  0: Colors.white,
  2: Color.fromARGB(255, 200, 230, 255),
  4: Color.fromARGB(255, 175, 220, 245),
  8: Color.fromARGB(255, 150, 210, 250),
  16: Color.fromARGB(255, 130, 190, 245),
  32: Color.fromARGB(255, 110, 170, 230),
  64: Color.fromARGB(255, 90, 150, 215),
  128: Color.fromARGB(255, 70, 130, 200),
  256: Color.fromARGB(255, 50, 110, 180),
  512: Color.fromARGB(255, 30, 90, 160),
  1024: Color.fromARGB(255, 10, 70, 140),
  2048: Color.fromARGB(255, 0, 50, 120),
  4096: Color.fromARGB(255, 0, 40, 100),
  8192: Color.fromARGB(255, 0, 30, 80),
};

ThemeData get pinkTheme => ThemeData(
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: lightPink,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.pink[900]),
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.pink[900]),
          fontWeight: FontWeight.w500,
        ),
        bodySmall: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.pink[900]),
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink[900],
          //textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          textStyle: GoogleFonts.fredoka(
            // Cambia "lobster" por la fuente que prefieras
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.pink[900],
        size: 36,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return softGreyPink;
          }
          return Colors.white; // Color cuando no está seleccionado
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.grey[700];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return softGreyPink;
          }
          return Colors.grey[300];
        }),
      ),
    );

ThemeData get purpleTheme => ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: lightPurple,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.varelaRound(
      textStyle: TextStyle(color: Colors.purple[900]),
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.varelaRound(
      textStyle: TextStyle(color: Colors.purple[900]),
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.varelaRound(
      textStyle: TextStyle(color: Colors.purple[900]),
      fontWeight: FontWeight.w500,
    ),
  ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple[900],
          textStyle: GoogleFonts.varelaRound(
            // Cambia "lobster" por la fuente que prefieras
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.purple[900],
        size: 36,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return softGreyPurple;
          }
          return Colors.white; // Color cuando no está seleccionado
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.grey[700];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return softGreyPurple;
          }
          return Colors.grey[300];
        }),
      ),
    );

ThemeData get blueTheme => ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: lightBlueGreen,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.fredoka(
      textStyle: TextStyle(color: Colors.blue[900]),
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.fredoka(
      textStyle: TextStyle(color: Colors.blue[900]),
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.fredoka(
      textStyle: TextStyle(color: Colors.blue[900]),
      fontWeight: FontWeight.w500,
    ),
  ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue[900],
          textStyle: GoogleFonts.fredoka(
            // Cambia "lobster" por la fuente que prefieras
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.blue[900],
        size: 36,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return softGreyBlue;
          }
          return Colors.white; // Color cuando no está seleccionado
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.grey[700];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return softGreyBlue;
          }
          return Colors.grey[300];
        }),
      ),
    );
