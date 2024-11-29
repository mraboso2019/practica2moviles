import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class MusicState extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlayingMusic = false;
  bool _isSoundEffects = true;

  bool get isPlayingMusic => _isPlayingMusic;
  bool get isSoundEffects => _isSoundEffects;

  void startMusic() async {
    if (!_isPlayingMusic) {
      await _player.play(AssetSource('background_music.mp3')); // Asegúrate de que el path es correcto
      _player.pause;
      _isPlayingMusic = true;
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

  Future<void> soundButton() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle.load("assets/click.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }
}
