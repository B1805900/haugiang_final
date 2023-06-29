class ResultModel {
  String? cccd, idSurvey, idQuestion, answer;

  ResultModel({
    this.cccd,
    this.idSurvey,
    this.idQuestion,
    this.answer,
  });

    // Phương thức toJson để chuyển đối tượng thành Map
  Map<String, dynamic> toJson() {
    return {
      'cccd': cccd,
      'idSurvey': idSurvey,
      'idQuestion': idQuestion,
      'answer': answer,
    };
  }
}