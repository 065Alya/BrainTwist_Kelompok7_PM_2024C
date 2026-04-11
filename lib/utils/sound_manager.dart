import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final bg = AudioPlayer();

  // 🎵 BACKGROUND MUSIC
  static Future<void> playBg() async {
    await bg.setReleaseMode(ReleaseMode.loop);
    await bg.setVolume(1.0);
    await bg.play(AssetSource('sounds/bg_music.mp3'));
  }

  static Future<void> stopBg() async {
    await bg.stop();
  }

  // 🔊 SFX TANPA DELAY
  static Future<void> play(String file) async {
    final player = AudioPlayer(); // 🔥 buat baru tiap klik
    await player.setVolume(1.0);
    await player.play(AssetSource('sounds/$file'));
  }
}