class SurveydetailModel {
  String? idGroup;
  String? groupName;
  List<QuestionModel>? questions;

  SurveydetailModel(this.idGroup, this.groupName, this.questions);

  factory SurveydetailModel.fromJson(Map<String, dynamic> json) {
    List<QuestionModel> questions = (json['questions'] as List<dynamic>)
        .map((questionJson) => QuestionModel.fromJson(questionJson))
        .toList();

    return SurveydetailModel(
      json['id_group'],
      json['group_name'],
      questions,
    );
  }
}


class AnswerModel {
  String? answer;
  String? moveto;
  bool? isCheck;


  AnswerModel(this.answer, this.moveto, this.isCheck);

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      json['answer'],
      json['moveto'],
      json['isCheck'],
    );
  }
}

class QuestionModel {
  String idQuestion;
  String? question;
  int type;
  List<AnswerModel>? answers;


  QuestionModel(this.idQuestion, this.question, this.type, this.answers);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    List<AnswerModel> answerList = (json['answers'] as List<dynamic>)
        .map((answer) => AnswerModel.fromJson(answer))
        .toList();

    return QuestionModel(
      json['id_question'],
      json['question'],
      json['type'],
      answerList,
    );
  }
}

