import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/sound_manager.dart'; // 🔥 WAJIB

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SoundManager.init();

  runApp(BrainTwistApp());
}

class BrainTwistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}