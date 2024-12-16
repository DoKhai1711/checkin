part of 'culture_cubit.dart';

class CultureState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<NewsDto>? listData;

  const CultureState({
    this.loadDataStatus = LoadStatus.initial,
    this.listData,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        listData,
      ];

  CultureState copyWith({
    LoadStatus? loadDataStatus,
    List<NewsDto>? listData,
  }) {
    return CultureState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      listData: listData ?? this.listData,
    );
  }
}
