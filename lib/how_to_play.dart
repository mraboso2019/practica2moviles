import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene el fondo degradado definido en el tema actual a través del proveedor
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;

    // Interfaz de la pantalla
    return Scaffold(
      body: Container(
        // Aplica el fondo degradado al contenedor principal
        decoration: gradientDecoration,
        // Centra el contenido en la pantalla
        child: Center(
            child: Column(
          // Ajusta la columna al contenido
          mainAxisSize: MainAxisSize.min,
          children: [
            // Espaciador flexible para añadir margen superior
            const Spacer(flex: 4),
            Container(
              padding: EdgeInsets.all(24.0),
              // Ajusta el valor para el espacio alrededor de los textos
              child: Column(
                // Centra vertical y horizontalmente los elementos
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Fila para el título "HOW TO PLAY" y un ícono
                  Row(
                    // Centra los elementos horizontalmente
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // Espaciado interno
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        // Color y bordes
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        // Título principal
                        child: Text(
                          'HOW TO PLAY',
                          textAlign: TextAlign.center,
                          // Estilo del texto
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Espaciado entre el texto y el icono
                      SizedBox(width: 10),
                      Container(
                        // Espaciado interno del icono
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        // Bordes y color del contenedor
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        // Icono de pregunta
                        child: Icon(Icons.question_mark_rounded),
                      ),
                    ],
                  ),
                  // Espaciado vertical
                  SizedBox(height: 16),
                  // Texto explicativo
                  Text(
                    'Choose the column where you want the number on the screen to fall by tapping on the arrows below the grid',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Espacio vertical
                  SizedBox(height: 16),
                  // Fila con iconos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_down_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.keyboard_double_arrow_down_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.keyboard_double_arrow_down_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  // Espacio vertical
                  SizedBox(height: 16),
                  // Texto explicativo
                  Text(
                    'Swipe to combine equal tiles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Espacio vertical
                  SizedBox(height: 16),
                ],
              ),
            ),
            // Botón para volver a la pantalla anterior
            ElevatedButton(
              onPressed: () {
                // Cierra la pantalla actual
                Navigator.pop(context);
              },
              // Texto del botón
              child: Text('BACK'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            // Espaciador flexible para añadir margen inferior
            const Spacer(flex: 4),
          ],
        )),
      ),
    );
  }
}
