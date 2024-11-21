import 'package:flutter/material.dart';
import 'package:practica_2/home_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gradientDecoration =
        Provider.of<AppTheme>(context).gradientBackground;
    return Scaffold(
      body: Container(
        decoration: gradientDecoration,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 4),
            Container(
              padding: EdgeInsets.all(24.0),
              // Ajusta el valor para el espacio alrededor de los textos
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Text(
                          'HOW TO PLAY',
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
                        child: Icon(Icons.question_mark_rounded),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Choose the column where you want the number on the screen to fall by tapping on the arrows below the grid',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.keyboard_double_arrow_down_rounded, color: Colors.white,),
                      SizedBox(width: 16),
                      Icon(Icons.keyboard_double_arrow_down_rounded, color: Colors.white,),
                      SizedBox(width: 16),
                      Icon(Icons.keyboard_double_arrow_down_rounded, color: Colors.white,),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Swipe to combine equal tiles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('BACK'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2, 40),
              ),
            ),
            const Spacer(flex: 4),
          ],
        )),
      ),
    );
  }
}
