part of 'question_cubit.dart';

class QuestionState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? message;
  final GroupQuestionDto? data;
  final int index;
  final bool changeData;
  final bool hasAnswered;
  final int? answerIndex;

  const QuestionState({
    this.loadDataStatus = LoadStatus.initial,
    this.message,
    this.data,
    this.index = 0,
    this.changeData = false,
    this.hasAnswered = false,
    this.answerIndex,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        message,
        data,
        index,
        changeData,
        hasAnswered,
        answerIndex,
      ];

  QuestionState copyWith({
    LoadStatus? loadDataStatus,
    String? message,
    GroupQuestionDto? data,
    int? index,
    bool? changeData,
    bool? hasAnswered,
    int? answerIndex,
  }) {
    return QuestionState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      message: message ?? this.message,
      data: data ?? this.data,
      index: index ?? this.index,
      changeData: changeData ?? this.changeData,
      hasAnswered: hasAnswered ?? this.hasAnswered,
      answerIndex: answerIndex ?? this.answerIndex,
    );
  }
}
