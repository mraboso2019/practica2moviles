import 'package:flutter/material.dart';
import 'home_screen.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('MENU'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('THEME'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
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
