import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GroupQuestionDto {
  int? setid;
  String? title;
  String? type;
  List<QuestionDto?>? list;

  GroupQuestionDto({this.setid, this.title, this.type, this.list});

  GroupQuestionDto.fromJson(Map<String, dynamic> json) {
    setid = json['set_id'];
    title = json['title'];
    type = json['type'];
    if (json['list'] != null) {
      list = <QuestionDto>[];
      json['list'].forEach((v) {
        list!.add(QuestionDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['set_id'] = setid;
    data['title'] = title;
    data['type'] = type;
    data['list'] = list != null ? list!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

@JsonSerializable()
class QuestionDto {
  int? questionid;
  String? questiontext;
  String? questionImg;
  List<AnswerDto?>? list;

  QuestionDto({
    this.questionid,
    this.questiontext,
    this.questionImg,
    this.list,
  });

  QuestionDto.fromJson(Map<String, dynamic> json) {
    questionid = json['question_id'];
    questiontext = json['question_text'];
    questionImg = json['question_img'];
    if (json['list'] != null) {
      list = <AnswerDto>[];
      json['list'].forEach((v) {
        list!.add(AnswerDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['question_id'] = questionid;
    data['question_text'] = questiontext;
    data['question_img'] = questionImg;
    data['list'] = list != null ? list!.map((v) => v?.toJson()).toList() : null;

    return data;
  }
}

@JsonSerializable()
class AnswerDto {
  String? answertext;
  int? iscorrect;

  AnswerDto({this.answertext, this.iscorrect});

  AnswerDto.fromJson(Map<String, dynamic> json) {
    answertext = json['answer_text'];
    iscorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['answer_text'] = answertext;
    data['is_correct'] = iscorrect;
    return data;
  }
}
