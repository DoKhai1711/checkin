part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus loadDataStatus;
  final Map<String, dynamic>? profile;
  final String? username;
  final bool changeData;
  final bool isShowMoney;

  const HomeState({
    this.loadDataStatus = LoadStatus.initial,
    this.profile,
    this.username,
    this.changeData = false,
    this.isShowMoney = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        profile,
        username,
        changeData,
        isShowMoney,
      ];

  HomeState copyWith({
    LoadStatus? loadDataStatus,
    Map<String, dynamic>? profile,
    String? username,
    bool? changeData,
    bool? isShowMoney,
  }) {
    return HomeState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      profile: profile ?? this.profile,
      username: username ?? this.username,
      changeData: changeData ?? this.changeData,
      isShowMoney: isShowMoney ?? this.isShowMoney,
    );
  }
}
