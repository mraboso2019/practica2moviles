import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          // Obtener el índice actual del tema
          int currentThemeIndex = appTheme.currentThemeIndex;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckboxListTile(
                title: Text("Pink"),
                value: appTheme.currentThemeIndex == 0,
                onChanged: (value) {
                  if (value == true) appTheme.changeTheme(0); // Pink Theme
                },
              ),
              CheckboxListTile(
                title: Text("Blue"),
                value: appTheme.currentThemeIndex == 1,
                onChanged: (value) {
                  if (value == true) appTheme.changeTheme(1); // Blue Theme
                },
              ),
              CheckboxListTile(
                title: Text("Purple"),
                value: appTheme.currentThemeIndex == 2,
                onChanged: (value) {
                  if (value == true) appTheme.changeTheme(2); // Blue Theme
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Volver atrás
                },
                child: Text("BACK"),
              ),
            ],
          );
        },
      ),
    );
  }
}
