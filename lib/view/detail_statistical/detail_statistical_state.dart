part of 'detail_statistical_cubit.dart';

class DetailStatisticalState extends Equatable {
  final LoadStatus loadDataStatus;
  final Map<String, dynamic>? profile;
  final String? username;
  final bool changeData;
  final List<Visited>? listHistory;
  final int totalCustomer;
  final int totalMoney;

  const DetailStatisticalState({
    this.loadDataStatus = LoadStatus.initial,
    this.profile,
    this.username,
    this.changeData = false,
    this.listHistory,
    this.totalCustomer = 0,
    this.totalMoney = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        profile,
        username,
        changeData,
        listHistory,
        totalCustomer,
        totalMoney,
      ];

  DetailStatisticalState copyWith({
    LoadStatus? loadDataStatus,
    Map<String, dynamic>? profile,
    String? username,
    bool? changeData,
    List<Visited>? listHistory,
    int? totalCustomer,
    int? totalMoney,
  }) {
    return DetailStatisticalState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      profile: profile ?? this.profile,
      username: username ?? this.username,
      changeData: changeData ?? this.changeData,
      listHistory: listHistory ?? this.listHistory,
      totalCustomer: totalCustomer ?? this.totalCustomer,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }
}
