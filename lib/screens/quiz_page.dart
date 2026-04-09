import 'dart:async';
import 'package:flutter/material.dart';
import '../data/question_bank.dart';
import '../models/question_model.dart';
import '../utils/sound_manager.dart';
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
  int timeLeft = 15;
  Timer? timer;
  int? selectedIndex;

  int getTime() {
    if (widget.level == "mudah") return 15;
    if (widget.level == "sedang") return 20;
    return 25;
  }

  @override
  void initState() {
    super.initState();
    questions = getRandomQuestions(widget.level);

    SoundManager.playBg();
    startTimer();
  }

  // ⏱ TIMER
  void startTimer() {
    timer?.cancel();
    timeLeft = getTime();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;

        if (timeLeft == 0) {
          SoundManager.play("timeout.mp3");
          next(); // ❌ tidak mengurangi score
        }
      });
    });
  }

  // 🎯 PILIH JAWABAN
  void answer(int i) {
    if (selectedIndex != null) return;

    timer?.cancel();
    setState(() => selectedIndex = i);

    if (i == questions[index].answerIndex) {
      correct++;
      score += (timeLeft > getTime() / 2) ? 50 : 30;
      SoundManager.play("correct.mp3");
    } else {
      // ❌ tidak ada minus score
      SoundManager.play("wrong.mp3");
    }

    Future.delayed(Duration(milliseconds: 800), next);
  }

  // 🎨 WARNA JAWABAN
  Color getColor(int i) {
    if (selectedIndex == null) return Colors.indigo;

    if (i == questions[index].answerIndex) return Colors.green;
    if (i == selectedIndex) return Colors.red;

    return Colors.indigo;
  }

  // ➡️ NEXT
  void next() {
    if (index < questions.length - 1) {
      setState(() {
        index++;
        selectedIndex = null;
      });
      startTimer();
    } else {
      nextLevel();
    }
  }

  // 🔄 LEVEL
  void nextLevel() {
    SoundManager.stopBg();

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
    timer?.cancel();
    super.dispose();
  }

  // 🔵 TIMER LINGKARAN
  Widget buildTimer() {
    double progress = timeLeft / getTime();

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation(
              progress < 0.3 ? Colors.red : Colors.cyanAccent,
            ),
          ),
        ),
        Text(
          "$timeLeft",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var q = questions[index];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // 🔹 HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Score: ${widget.totalScore + score}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.cyanAccent, Colors.blue],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "$timeLeft",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔥 QUESTION FLEX (BIAR PROPORSIONAL)
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E293B), Color(0xFF312E81)],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (q.imagePath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              q.imagePath!,
                              height: 140,
                            ),
                          ),

                        const SizedBox(height: 10),

                        Text(
                          q.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 🔥 ANSWER FLEX (ISI RUANG BESAR)
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                    itemCount: q.options.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.6, // lebih tinggi
                    ),
                    itemBuilder: (context, i) {
                      Color color = const Color(0xFF1E3A8A);

                      if (selectedIndex != null) {
                        if (i == q.answerIndex) {
                          color = Colors.green;
                        } else if (i == selectedIndex) {
                          color = Colors.red;
                        }
                      }

                      return GestureDetector(
                        onTap: () => answer(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          transform: Matrix4.identity()
                            ..scaleByDouble(
                              selectedIndex == i ? 0.95 : 1,
                              selectedIndex == i ? 0.95 : 1,
                              1,
                              1,
                            ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                color,
                                color.withValues(alpha: 0.85),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text(
                                q.options[i],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 PROGRESS
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    child: LinearProgressIndicator(
                      value: (index + 1) / questions.length,
                      minHeight: 10,
                      backgroundColor: Colors.white24,
                      color: Colors.cyanAccent,
                    ),
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