part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadDataStatus;

  const HomeState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  HomeState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return HomeState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
