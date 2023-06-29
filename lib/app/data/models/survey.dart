class SurveyModel {
  String? idSurvey, nameSurvey, timeCreate, timeEnd, userName;

  SurveyModel(
    this.idSurvey,
    this.nameSurvey,
    this.timeCreate,
    this.timeEnd,
    this.userName,
  );

  SurveyModel.fromJson(Map<String, dynamic> json) {
    idSurvey = json['idSurvey'];
    nameSurvey = json['nameSurvey'];
    timeCreate = json['tenlop'];
    timeEnd = json['time'];
    userName = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSurvey'] = idSurvey;
    data['nameSurvey'] = nameSurvey;
    data['tenlop'] = timeCreate;
    data['time'] = timeEnd;
    data['username'] = userName;
    return data;
  }
}
