import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicState extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlayingMusic = false;

  bool get isPlayingMusic => _isPlayingMusic;

  void startMusic() async {
    if (!_isPlayingMusic) {
      //await _player.play(AssetSource('background_music.mp3')); // Asegúrate de que el path es correcto
      _player.pause;
      _isPlayingMusic = false;
      notifyListeners();
    }
  }

  void toggleMusic() async {
    if (_isPlayingMusic) {
      await _player.pause();
    } else {
      await _player.play(AssetSource('background_music.mp3'));
    }
    _isPlayingMusic = !_isPlayingMusic;
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
