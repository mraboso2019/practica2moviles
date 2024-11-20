import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicTest extends StatelessWidget {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Play'),
                  onPressed: () {
                    //player.play('background_music.mp3');
                    player.play(AssetSource('background_music.mp3'));
                  },
                ),
                ElevatedButton(
                  child: Text('Pause'),
                  onPressed: () {
                    //player.play('background_music.mp3');
                    player.pause();
                  },
                ),
              ],
            )));
  }
}
