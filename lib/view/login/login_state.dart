part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? username;
  final String? password;
  final Map<String, dynamic>? listAcc;
  final bool changeData;

  const LoginState({
    this.loadDataStatus = LoadStatus.initial,
    this.username,
    this.password,
    this.listAcc,
    this.changeData = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        username,
        password,
        listAcc,
        changeData,
      ];

  LoginState copyWith({
    LoadStatus? loadDataStatus,
    String? username,
    String? password,
    Map<String, dynamic>? listAcc,
    bool? changeData,
  }) {
    return LoginState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      username: username ?? this.username,
      password: password ?? this.password,
      listAcc: listAcc ?? this.listAcc,
      changeData: changeData ?? this.changeData,
    );
  }
}
