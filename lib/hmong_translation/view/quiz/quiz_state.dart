part of 'quiz_cubit.dart';

class QuizState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<GroupQuestionDto>? data;

  const QuizState({
    this.loadDataStatus = LoadStatus.initial,
    this.data,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        data,
      ];

  QuizState copyWith({
    LoadStatus? loadDataStatus,
    List<GroupQuestionDto>? data,
  }) {
    return QuizState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      data: data ?? this.data,
    );
  }
}
