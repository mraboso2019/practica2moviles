import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isPink = true;
  bool isBlue = false;
  bool isPurple = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sound Effects'),
            Text('Theme:'),
            Column(
              children: [
                CheckboxListTile(
                  title: Text('Pink'),
                  value: isPink,
                  onChanged: (bool? value) {
                    setState(() {
                      isPink = value!;
                      isBlue = false;
                      isPurple = false;
                    });
                    Provider.of<AppTheme>(context, listen: false)
                        .setPinkTheme();
                  },
                ),
                CheckboxListTile(
                  title: Text('Purple'),
                  value: isPurple,
                  onChanged: (bool? value) {
                    setState(() {
                      isPink = false;
                      isBlue = false;
                      isPurple = value!;
                    });
                    Provider.of<AppTheme>(context, listen: false)
                        .setPurpleTheme();
                  },
                ),
                CheckboxListTile(
                  title: Text('Blue'),
                  value: isBlue,
                  onChanged: (bool? value) {
                    setState(() {
                      isPink = false;
                      isBlue = value!;
                      isPurple = false;
                    });
                    Provider.of<AppTheme>(context, listen: false)
                        .setBlueTheme();
                  },
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('BACK'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
