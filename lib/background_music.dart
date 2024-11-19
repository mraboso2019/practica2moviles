import 'package:audioplayers/audioplayers.dart';

class BackgroundMusic {
  static AudioPlayer _audioPlayer = AudioPlayer();

  // Iniciar la música de fondo
  static void playBackgroundMusic() async {
    // Establecer el origen del archivo de audio
    await _audioPlayer.setSource(AssetSource('assets/music/background_music.mp3'));
    // Configurar la música para que se repita en bucle
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    // Reproducir la música
    await _audioPlayer.play(AssetSource('assets/music/background_music.mp3'));
    //await _audioPlayer.resume();
  }

  // Detener la música de fondo
  static void stopBackgroundMusic() async {
    await _audioPlayer.stop();
  }
}
