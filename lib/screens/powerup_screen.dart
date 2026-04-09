import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/sound_manager.dart';
import 'quiz_page.dart';

class PowerUpScreen extends StatefulWidget {
  final String nextLevel;
  final int totalScore;
  final int totalCorrect;

  PowerUpScreen({
    required this.nextLevel,
    required this.totalScore,
    required this.totalCorrect,
  });

  @override
  State<PowerUpScreen> createState() => _PowerUpScreenState();
}

class _PowerUpScreenState extends State<PowerUpScreen> {

  @override
  void initState() {
    super.initState();

    SoundManager.play("power_up.mp3");

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizPage(
            level: widget.nextLevel,
            totalScore: widget.totalScore,
            totalCorrect: widget.totalCorrect,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Image.asset('assets/images/power_up.png', width: 700),
        ),
      ),
    );
  }
}