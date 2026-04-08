import 'dart:async';
import 'package:flutter/material.dart';
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
  _PowerUpScreenState createState() => _PowerUpScreenState();
}

class _PowerUpScreenState extends State<PowerUpScreen> {

  @override
  void initState() {
    super.initState();

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
      body: Center(
        child: Text("🧠 POWER UP BRAIN ⚡", style: TextStyle(fontSize: 26)),
      ),
    );
  }
}