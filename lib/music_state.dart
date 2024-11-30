import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clase para manejar el estado de la música y efectos de sonido
class MusicState extends ChangeNotifier {
  // Reproductor de música principal
  final AudioPlayer _player = AudioPlayer();

  // Indica si la música está activa
  bool _isPlayingMusic = true;
  bool _isSoundEffects = true;

  bool get isPlayingMusic => _isPlayingMusic;

  bool get isSoundEffects => _isSoundEffects;

  MusicState() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isPlayingMusic = prefs.getBool('isPlayingMusic') ?? true;
    _isSoundEffects = prefs.getBool('isSoundEffects') ?? true;
    if (_isPlayingMusic) {
      await startMusic(); // Reproducir música si está configurado para hacerlo
    }
    notifyListeners();
  }

  // Guardar el estado de la música en SharedPreferences
  Future<void> _saveMusicState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPlayingMusic', _isPlayingMusic);
  }

  // Guardar el estado de los efectos de sonido en SharedPreferences
  Future<void> _saveSoundEffectsState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundEffects', _isSoundEffects);
  }

  Future<void> startMusicIfNeeded() async {
    await _loadSettings(); // Asegurarse de que las configuraciones están cargadas
    if (_isPlayingMusic) {
      await startMusic(); // Comienza la música si está configurado
    }
  }

  Future<void> startMusic() async {
    if (!_isPlayingMusic) return;
    _player.setReleaseMode(ReleaseMode.loop); // Configura el bucle
    _player.setVolume(0.5);
    await _player.play(AssetSource(
        'background_music.mp3')); // Asegúrate de que el path es correcto
  }

  void toggleMusic() async {
    if (_isPlayingMusic) {
      await _player.pause();
    } else {
      await _player.play(AssetSource('background_music.mp3'));
    }
    _isPlayingMusic = !_isPlayingMusic;
    await _saveMusicState(); // Guardar el estado de la música
    notifyListeners();
  }

  void toggleSounds() async {
    _isSoundEffects = !_isSoundEffects;
    await _saveSoundEffectsState(); // Guardar el estado de los efectos de sonido  // Guardar el estado de la música
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> tapSound() async {
    if (_isSoundEffects) {
      Soundpool pool = Soundpool(streamType: StreamType.notification);

      int soundId =
          await rootBundle.load("assets/click.mp3").then((ByteData soundData) {
        return pool.load(soundData);
      });
      int streamId = await pool.play(soundId);
    }
  }

  Future<void> swipeSound() async {
    if (_isSoundEffects) {
      Soundpool pool = Soundpool(streamType: StreamType.notification);

      int soundId =
          await rootBundle.load("assets/swipe.mp3").then((ByteData soundData) {
        return pool.load(soundData);
      });
      int streamId = await pool.play(soundId);
    }
  }
}
