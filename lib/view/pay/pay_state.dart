part of 'pay_cubit.dart';

class PayState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final Map<String, dynamic>? listAccount;
  final bool changeData;
  final String? money;
  final String? username;
  final int score;

  const PayState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.changeData = false,
    this.listAccount,
    this.money,
    this.username,
    this.score = 1,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        saveStatus,
        listAccount,
        changeData,
        money,
        username,
        score,
      ];

  PayState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    Map<String, dynamic>? listAccount,
    bool? changeData,
    String? money,
    String? username,
    int? score,
  }) {
    return PayState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      changeData: changeData ?? this.changeData,
      listAccount: listAccount ?? this.listAccount,
      money: money ?? this.money,
      username: username ?? this.username,
      score: score ?? this.score,
    );
  }
}
