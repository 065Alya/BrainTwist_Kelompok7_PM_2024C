class Question {
  String question;
  List<String> options;
  int answerIndex;
  String level;
  String? imagePath;

  Question(this.question, this.options, this.answerIndex, this.level,
      {this.imagePath});
}