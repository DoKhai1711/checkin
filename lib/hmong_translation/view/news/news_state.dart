part of 'news_cubit.dart';

class NewsState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<NewsDto>? listData;

  const NewsState({
    this.loadDataStatus = LoadStatus.initial,
    this.listData,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        listData,
      ];

  NewsState copyWith({
    LoadStatus? loadDataStatus,
    List<NewsDto>? listData,
  }) {
    return NewsState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      listData: listData ?? this.listData,
    );
  }
}
