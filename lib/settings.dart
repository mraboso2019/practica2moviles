import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'music_state.dart';

class Settings extends StatefulWidget {
  @override
  // Crea el estado asociado con la configuración
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    // Obtiene el fondo con gradiente desde el estado global del tema
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;
    // Obtiene el estado de la música desde el proveedor
    final musicState = Provider.of<MusicState>(context);

    // Interfaz de la pantalla
    return Scaffold(
      body: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return Container(
            // Aplica el fondo con gradiente
            decoration: gradientDecoration,
            child: Center(
              child: Column(
                // Centra los elementos verticalmente
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Agrega espacio proporcional en la parte superior
                  const Spacer(flex: 4),
                  // Fila de título y un icono para la sección de configuración
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Contenedor con el título
                      Container(
                        // Espaciado interno
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        // Fondo blanco y bordes redondos
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Text(
                          'SETTINGS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Espacio entre elementos
                      SizedBox(width: 10),
                      // Contenedor con icono
                      Container(
                        // Espaciado interno
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        // Fondo blanco y bordes redondos
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.settings),
                      ),
                    ],
                  ),
                  // Espaciador entre secciones
                  const Spacer(flex: 2),
                  // Contenedor para la opción de 'MUSIC'
                  Container(
                    // Ancho relativo al tamaño de la pantalla
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    // Texto del contenedor
                    child: Text(
                      'MUSIC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 1),
                  // Contenedor para el interruptor de música
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          // Muestra 'ON' o 'OFF' según el estado
                          child: Text(
                            musicState.isPlayingMusic ? 'ON' : 'OFF',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        // Espacio entre elementos
                        Spacer(),
                        // Espaciado interno
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          // Estado del interruptor de música
                          child: Switch(
                            value: musicState.isPlayingMusic,
                            onChanged: (value) {
                              // Cambia el estado de la música
                              musicState.toggleMusic();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 2),
                  // Contenedor para la opción de 'SOUND EFFECTS'
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    // Color blanco y bordes redondeados
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    // Texto del contenedor
                    child: Text(
                      'SOUND EFFECTS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Espacio entre elementos
                  const Spacer(flex: 1),
                  // Contenedor para el interruptor de efectos de sonido
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          // Muestra 'ON' o 'OFF' según el estado
                          child: Text(
                            musicState.isSoundEffects ? 'ON' : 'OFF',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        // Espacio entre elementos
                        Spacer(),
                        // Espaciado interno
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Switch(
                            // Estado del interruptor de efectos de sonido
                            value: musicState.isSoundEffects,
                            onChanged: (value) {
                              // Cambia el estado de los efectos de sonido
                              musicState.toggleSounds();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 2),
                  // Contenedor para la opción de 'THEME'
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    // Fondo blanco y bordes redondeados
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    // Texto del contenedor
                    child: Text(
                      'THEME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 1),
                  // Contenedor para la opción de selección del tema 'PINK'
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    // Título del tema
                    child: CheckboxListTile(
                      title: Text("PINK"),
                      // Verifica si el tema actual es 'PINK'
                      value: appTheme.currentThemeIndex == 0,
                      onChanged: (value) {
                        // Cambia al tema 'PINK'
                        if (value == true) appTheme.changeTheme(0);
                      },
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 1),
                  // Contenedor para la opción de selección del tema 'BLUE'
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: CheckboxListTile(
                      // Título del tema
                      title: Text("BLUE"),
                      // Verifica si el tema actual es 'BLUE'
                      value: appTheme.currentThemeIndex == 1,
                      onChanged: (value) {
                        // Cambia al tema 'BLUE'
                        if (value == true) appTheme.changeTheme(1);
                      },
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 1),
                  // Contenedor para la opción de selección del tema 'PURPLE'
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: CheckboxListTile(
                      title: Text("PURPLE"),
                      // Verifica si el tema actual es 'PURPLE'
                      value: appTheme.currentThemeIndex == 2,
                      onChanged: (value) {
                        // Cambia al tema 'PURPLE'
                        if (value == true) appTheme.changeTheme(2);
                      },
                    ),
                  ),
                  // Espaciador
                  const Spacer(flex: 2),
                  // Botón para volver atrás a la pantalla anterior
                  ElevatedButton(
                    onPressed: () {
                      // Cierra la pantalla actual
                      Navigator.pop(context);
                    },
                    // Texto del botón
                    child: Text("BACK"),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 40),
                    ),
                  ),
                  // Espaciado con la parte inferior
                  const Spacer(flex: 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
