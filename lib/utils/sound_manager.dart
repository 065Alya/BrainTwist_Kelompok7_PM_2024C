import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final bg = AudioPlayer();
  static final sfx = AudioPlayer();

  static Future<void> init() async {
    await bg.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
        ),
      ),
    );
  }

  static Future<void> playBg() async {
    await bg.setReleaseMode(ReleaseMode.loop);
    await bg.setVolume(1.0);
    await bg.play(AssetSource('sounds/bg_music.mp3'));
  }

  static Future<void> stopBg() async {
    await bg.stop();
  }

  static Future<void> play(String file) async {
    await sfx.setVolume(1.0);
    await sfx.play(AssetSource('sounds/$file'));
  }
}