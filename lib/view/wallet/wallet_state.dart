part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final Map<String, dynamic>? profile;
  final String? username;
  final String? type;

  const WalletState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.profile,
    this.username,
    this.type,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        saveStatus,
        profile,
        username,
        type,
      ];

  WalletState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    Map<String, dynamic>? profile,
    String? username,
    String? type,
  }) {
    return WalletState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      profile: profile ?? this.profile,
      username: username ?? this.username,
      type: type ?? this.type,
    );
  }
}
