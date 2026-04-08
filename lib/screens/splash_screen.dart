import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  bool showButton = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    player.play(AssetSource('sounds/start.mp3'));

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() => opacity = 1);
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() => showButton = true);
    });
  }

  void startGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizPage(level: "mudah"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 2),
              child: Image.asset('assets/images/logo.png', width: 150),
            ),
            SizedBox(height: 40),
            if (showButton)
              ElevatedButton(
                onPressed: startGame,
                child: Text("Start Game"),
              )
          ],
        ),
      ),
    );
  }
}