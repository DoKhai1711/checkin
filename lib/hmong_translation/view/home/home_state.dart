part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadDataStatus;
  final int pageIndex;

  const HomeState({
    this.loadDataStatus = LoadStatus.initial,
    this.pageIndex = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        pageIndex,
      ];

  HomeState copyWith({
    LoadStatus? loadDataStatus,
    int? pageIndex,
  }) {
    return HomeState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
