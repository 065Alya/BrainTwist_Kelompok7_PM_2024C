import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/question_bank.dart';
import '../models/question_model.dart';
import 'powerup_screen.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final String level;
  final int totalScore;
  final int totalCorrect;

  const QuizPage({
    super.key,
    required this.level,
    this.totalScore = 0,
    this.totalCorrect = 0,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Question> questions;
  int index = 0;
  int score = 0;
  int correct = 0;
  int timeLeft = 10;
  late Timer timer;

  final player = AudioPlayer();
  final bgPlayer = AudioPlayer();

  int getTime() {
    if (widget.level == "mudah") return 15;
    if (widget.level == "sedang") return 20;
    return 25;
  }

  @override
  void initState() {
    super.initState();

    questions = getRandomQuestions(widget.level);

    // 🔊 Background Music
    bgPlayer.setReleaseMode(ReleaseMode.loop);
    bgPlayer.setVolume(1.0); // MAX VOLUME
    bgPlayer.play(AssetSource('sounds/bg_music.mp3'));

    // 🔊 Effect Sound
    player.setVolume(1.0);

    startTimer();
  }

  void startTimer() {
    timeLeft = getTime();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft == 0) {
          player.play(AssetSource('sounds/timeout.mp3'), volume: 1.0);
          score--;
          next();
        }
      });
    });
  }

  void answer(int i) {
    timer.cancel();

    if (i == questions[index].answerIndex) {
      score++;
      correct++;
      player.play(AssetSource('sounds/correct.mp3'), volume: 1.0);
    } else {
      player.play(AssetSource('sounds/wrong.mp3'), volume: 1.0);
    }

    Future.delayed(const Duration(milliseconds: 800), next);
  }

  void next() {
    timer.cancel();

    if (index < questions.length - 1) {
      setState(() => index++);
      startTimer();
    } else {
      nextLevel();
    }
  }

  void nextLevel() {
    bgPlayer.stop();

    if (widget.level == "mudah") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              PowerUpScreen(
                nextLevel: "sedang",
                totalScore: widget.totalScore + score,
                totalCorrect: widget.totalCorrect + correct,
              ),
        ),
      );
    } else if (widget.level == "sedang") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              PowerUpScreen(
                nextLevel: "sulit",
                totalScore: widget.totalScore + score,
                totalCorrect: widget.totalCorrect + correct,
              ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ResultPage(
                score: widget.totalScore + score,
                correct: widget.totalCorrect + correct,
              ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    bgPlayer.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var q = questions[index];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E1B4B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.level.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text("⏱ $timeLeft",
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),

                const SizedBox(height: 20),

                // QUESTION CARD
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  child: Column(
                    children: [
                      if (q.imagePath != null)
                        Image.asset(q.imagePath!, height: 150),

                      const SizedBox(height: 10),

                      Text(
                        q.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PROGRESS
                LinearProgressIndicator(
                  value: (index + 1) / questions.length,
                  backgroundColor: Colors.white24,
                  color: Colors.cyanAccent,
                ),

                const SizedBox(height: 20),

                // OPTIONS GRID
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(q.options.length, (i) {
                      return GestureDetector(
                        onTap: () => answer(i),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1E3A8A),
                                Color(0xFF312E81)
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              q.options[i],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}