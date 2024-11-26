part of 'translate_cubit.dart';

class TranslateState extends Equatable {
  final LoadStatus loadDataStatus;

  const TranslateState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  TranslateState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return TranslateState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
