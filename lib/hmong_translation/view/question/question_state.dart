part of 'question_cubit.dart';

class QuestionState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? message;
  final GroupQuestionDto? data;
  final int index;

  const QuestionState({
    this.loadDataStatus = LoadStatus.initial,
    this.message,
    this.data,
    this.index = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        message,
        data,
        index,
      ];

  QuestionState copyWith({
    LoadStatus? loadDataStatus,
    String? message,
    GroupQuestionDto? data,
    int? index,
  }) {
    return QuestionState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      message: message ?? this.message,
      data: data ?? this.data,
      index: index ?? this.index,
    );
  }
}
