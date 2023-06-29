class QuestionModel {
  final String id;
  final String question;
  final List<String> answers;
  bool isSelected;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    this.isSelected = false,
  });
}
