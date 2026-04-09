import 'package:flutter/material.dart';
import '../utils/sound_manager.dart';
import 'quiz_page.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int correct;

  ResultPage({required this.score, required this.correct});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  void initState() {
    super.initState();
    SoundManager.play("finish.mp3");
  }

  @override
  Widget build(BuildContext context) {
    double accuracy = (widget.correct / 30) * 100;

    return Scaffold(
        body: Container(
            color: Colors.black,
            child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/skor_akhir.png',
                      width: 350,
                    ),

// 🔢 SCORE (kiri)
                    Positioned(
                      bottom: 100,
                      left: 105,
                      child: Text(
                        "${widget.score}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.cyanAccent,
                            )
                          ],
                        ),
                      ),
                    ),

// 🎯 ACCURACY (kanan)
                    Positioned(
                      bottom: 100,
                      right: 60,
                      child: Text(
                        "${accuracy.toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.purpleAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                    // 🔁 BUTTON
                    Positioned(
                      bottom: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizPage(level: "mudah"),
                            ),
                          );
                        },
                        child: Text("MAIN LAGI"),
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}