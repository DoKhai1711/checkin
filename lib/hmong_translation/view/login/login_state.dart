part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final bool changeData;
  final String? username;
  final String? password;

  const LoginState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.changeData = false,
    this.username,
    this.password,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        saveStatus,
        changeData,
        username,
        password,
      ];

  LoginState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    bool? changeData,
    String? username,
    String? password,
  }) {
    return LoginState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      changeData: changeData ?? this.changeData,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
