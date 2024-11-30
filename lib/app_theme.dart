import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  // Guarda el íindice del tema actual
  int _currentThemeIndex = 0;

  // Getter que devuelve el tema del índice actual
  int get currentThemeIndex => _currentThemeIndex;

  // Variable ThemeData que guarda el tema actual
  ThemeData _currentTheme = pinkTheme;

  // Getter que devuelve el tema actual
  ThemeData get currentTheme => _currentTheme;

  // Colores asociados a las celdas del tablero
  Map<int, Color> numTileColor = pinkTileColors;

  // Color del texto de las celdas
  Color tileFontColor = Colors.pink[900]!;

  // Color del fondo del tablero
  Color gridBackGroundColor = softGreyPink;

  // Color de fondo general de la pantalla
  Color backgroundColor = lightPink;

  // Constructor que carga el tema cuando se inicializa la clase
  AppTheme() {
    _loadTheme();
  }

  // Método para cargar el tema guardado en SharedPreferences
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Si no hay tema guardado, se usa 0
    _currentThemeIndex =
        prefs.getInt('currentThemeIndex') ?? 0; // 0 es el valor por defecto
    // Aplica el tema según el índice guardado
    _applyTheme(_currentThemeIndex);
  }

  // Método para guardar el tema en SharedPreferences
  void _saveTheme(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentThemeIndex', themeIndex);
  }

  // Método para aplicar el tema según el índice dado
  void _applyTheme(int themeIndex) {
    // Aplica el tema correspondiente dependiendo del índice
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
      // Si el índice no es válido, se aplica el tema rosa
      default:
        setPinkTheme(); // Tema por defecto
    }
    // Notifica a los listeners (widgets que usan este tema) para que se actualicen
    notifyListeners();
  }

  // Configura los colores y el estilo del tema rosa
  void setPinkTheme() {
    _currentTheme = pinkTheme;
    tileFontColor = Colors.pink[900]!;
    numTileColor = pinkTileColors;
    gridBackGroundColor = softGreyPink;
    backgroundColor = lightPink;
  }

  // Configura los colores y el estilo del tema morado
  void setPurpleTheme() {
    _currentTheme = purpleTheme;
    tileFontColor = Colors.white;
    numTileColor = purpleTileColors;
    gridBackGroundColor = softGreyPurple;
    backgroundColor = lightPurple;
  }

  // Configura los colores y el estilo del tema azul
  void setBlueTheme() {
    _currentTheme = blueTheme;
    tileFontColor = Colors.blue[900]!;
    numTileColor = blueGreenTileColors;
    gridBackGroundColor = softGreyBlue;
    backgroundColor = lightBlueGreen;
  }

  // Método para cambiar el tema y actualizar SharedPreferences
  void changeTheme(int themeIndex) async {
    // Guardar el índice del tema
    _currentThemeIndex = themeIndex;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentThemeIndex', themeIndex);

    _applyTheme(_currentThemeIndex);
    _saveTheme(_currentThemeIndex);
  }

  // Devuelve un fondo con un gradiente basado en los colores del tema actual
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

// Definición de colores para los temas (rosas, morados, azules, etc.)
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

// Mapas de colores para las celdas del tablero (tiles) según el tema
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

// Tema Rosa
ThemeData get pinkTheme => ThemeData(
      // Color principal del tema
      primarySwatch: Colors.pink,
      // Color de fondo principal de la pantalla
      scaffoldBackgroundColor: lightPink,

      // Configuración de los estilos de texto
      textTheme: TextTheme(
        // Estilo para textos grandes
        bodyLarge: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.pink[900]),
          fontWeight: FontWeight.w500,
        ),
        // Estilo para textos medianos
        bodyMedium: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.pink[900]),
          fontWeight: FontWeight.w500,
        ),
        // Estilo para textos pequeños
        bodySmall: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.pink[900]),
          fontWeight: FontWeight.w500,
        ),
      ),
      // Estilo de los botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Color de fondo del botón
          backgroundColor: Colors.white,
          // Color del texto en el botón
          foregroundColor: Colors.pink[900],
          // Estilo del texto
          textStyle: GoogleFonts.fredoka(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      // Estilo de los iconos
      iconTheme: IconThemeData(
        color: Colors.pink[900],
        size: 36,
      ),
      // Estilo de los checkboxes
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            // Color cuando está seleccionado
            return softGreyPink;
          }
          // Color cuando no está seleccionado
          return Colors.white;
        }),
      ),
      // Estilo de los interruptores (switches)
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            // Color cuando está seleccionado
            return Colors.white;
          }
          // Color cuando no está seleccionado
          return Colors.grey[700];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            // Color de la pista seleccionada
            return softGreyPink;
          }
          // Color de la pista no seleccionada
          return Colors.grey[300];
        }),
      ),
    );

// Tema Morado
ThemeData get purpleTheme => ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: lightPurple,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.purple[900]),
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.purple[900]),
          fontWeight: FontWeight.w500,
        ),
        bodySmall: GoogleFonts.fredoka(
          textStyle: TextStyle(color: Colors.purple[900]),
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple[900],
          textStyle: GoogleFonts.fredoka(
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
          return Colors.white;
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

// Tema Azul
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
          return Colors.white;
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
