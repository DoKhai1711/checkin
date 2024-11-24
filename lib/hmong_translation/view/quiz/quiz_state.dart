part of 'quiz_cubit.dart';

class QuizState extends Equatable {
  final LoadStatus loadDataStatus;

  const QuizState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  QuizState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return QuizState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
