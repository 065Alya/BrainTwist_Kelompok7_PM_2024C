import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(BrainTwistApp());
}

class BrainTwistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}