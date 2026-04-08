import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int correct;

  ResultPage({required this.score, required this.correct});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.play(AssetSource('sounds/finish.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    double accuracy = (widget.correct / 30) * 100;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score: ${widget.score}/30"),
            Text("Accuracy: ${accuracy.toStringAsFixed(1)}%"),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Main Lagi"),
            )
          ],
        ),
      ),
    );
  }
}