import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'package:audioplayers/audioplayers.dart';
import 'music_state.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;
    final musicState = Provider.of<MusicState>(context);
    return Scaffold(
      body: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          // Obtener el índice actual del tema
          int currentThemeIndex = appTheme.currentThemeIndex;
          return Container(
            decoration: gradientDecoration,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
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
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.settings),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Text(
                      'MUSIC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
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
                          child: Text(
                            musicState.isPlayingMusic ? 'ON' : 'OFF',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Switch(
                            value: musicState.isPlayingMusic,
                            onChanged: (value) {
                              musicState.toggleMusic();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Text(
                      'SOUND EFFECTS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
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
                          child: Text(
                            musicState.isSoundEffects ? 'ON' : 'OFF',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Switch(
                            value: musicState.isSoundEffects,
                            onChanged: (value) {
                              musicState.toggleSounds();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Text(
                      'THEME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: CheckboxListTile(
                      title: Text("PINK"),
                      value: appTheme.currentThemeIndex == 0,
                      onChanged: (value) {
                        if (value == true) appTheme.changeTheme(0);
                      },
                    ),
                  ),
                  const Spacer(flex: 1),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: CheckboxListTile(
                      title: Text("BLUE"),
                      value: appTheme.currentThemeIndex == 1,
                      onChanged: (value) {
                        if (value == true) appTheme.changeTheme(1);
                      },
                    ),
                  ),
                  const Spacer(flex: 1),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: CheckboxListTile(
                      title: Text("PURPLE"),
                      value: appTheme.currentThemeIndex == 2,
                      onChanged: (value) {
                        if (value == true) appTheme.changeTheme(2);
                      },
                    ),
                  ),
                  const Spacer(flex: 2),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Volver atrás
                    },
                    child: Text("BACK"),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 40),
                    ),
                  ),
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
