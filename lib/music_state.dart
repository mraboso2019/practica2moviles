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

  // Indica si los efectos están activos
  bool _isSoundEffects = true;

  // Getters para acceder al estado de la música y efectos de sonido
  bool get isPlayingMusic => _isPlayingMusic;

  bool get isSoundEffects => _isSoundEffects;

  // Constructor que carga las configuraciones iniciales
  MusicState() {
    // Cargar configuraciones desde SharedPreferences
    _loadSettings();
  }

  // Carga las configuraciones de música y efectos de sonido desde SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    // Carga el estado de la música, predeterminando en `true` si no está configurado
    _isPlayingMusic = prefs.getBool('isPlayingMusic') ?? true;
    // Carga el estado de los efectos de sonido, predeterminando en `true` si no está configurado
    _isSoundEffects = prefs.getBool('isSoundEffects') ?? true;
    // Si la música está habilitada, inicia la reproducción
    if (_isPlayingMusic) {
      await startMusic();
    }
    // Notifica a los widgets que el estado ha cambiado
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

  // Verifica las configuraciones y comienza la música si está habilitada
  Future<void> startMusicIfNeeded() async {
    // Asegura que las configuraciones estén cargadas
    await _loadSettings();
    // Inicia la música
    if (_isPlayingMusic) {
      await startMusic();
    }
  }

  // Inicia la reproducción de música
  Future<void> startMusic() async {
    // Si la música no está habilitada, no hacer nada
    if (!_isPlayingMusic) return;
    // Configura la música en bucle
    _player.setReleaseMode(ReleaseMode.loop);
    // Establece el volumen al 50%
    _player.setVolume(0.5);
    // Reproduce el archivo de música
    await _player.play(AssetSource(
        'background_music.mp3')); // Asegúrate de que el path es correcto
  }

  // Alterna el estado de la música (activar/desactivar)
  void toggleMusic() async {
    // Pausa la música si está activa
    if (_isPlayingMusic) {
      await _player.pause();
    } // Reproduce la música si está desactivada
    else {
      await _player.play(AssetSource('background_music.mp3'));
    }
    // Cambia el estado
    _isPlayingMusic = !_isPlayingMusic;
    // Guarda el nuevo estado en SharedPreferences
    await _saveMusicState();
    // Notifica a los widgets que el estado ha cambiado
    notifyListeners();
  }

  // Alterna el estado de los efectos de sonido (activar/desactivar)
  void toggleSounds() async {
    // Cambia el estado
    _isSoundEffects = !_isSoundEffects;
    // Guarda el nuevo estado en SharedPreferences
    await _saveSoundEffectsState();
    // Notifica a los widgets que el estado ha cambiado
    notifyListeners();
  }

  // Limpia los recursos al destruir la instancia
  @override
  void dispose() {
    // Libera el reproductor de música
    _player.dispose();
    super.dispose();
  }

  // Reproduce un sonido al tocar (si los efectos de sonido están activos)
  Future<void> tapSound() async {
    // Crea un Soundpool para reproducir el efecto
    if (_isSoundEffects) {
      Soundpool pool = Soundpool(streamType: StreamType.notification);

      // Carga el archivo de sonido
      int soundId =
          await rootBundle.load("assets/click.mp3").then((ByteData soundData) {
        // Carga el sonido en el Soundpool
        return pool.load(soundData);
      });
      // Reproduce el sonido
      int streamId = await pool.play(soundId);
    }
  }

  // Reproduce un sonido al deslizar (si los efectos de sonido están activos)
  Future<void> swipeSound() async {
    // Crea un Soundpool para reproducir el efecto
    if (_isSoundEffects) {
      Soundpool pool = Soundpool(streamType: StreamType.notification);

      // Carga el archivo de sonido
      int soundId =
          await rootBundle.load("assets/swipe.mp3").then((ByteData soundData) {
        // Carga el sonido en el Soundpool
        return pool.load(soundData);
      });
      // Reproduce el sonido
      int streamId = await pool.play(soundId);
    }
  }
}
