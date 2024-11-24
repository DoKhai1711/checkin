part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final bool changeData;
  final String? username;
  final String? password;
  final String? passwordAgain;

  const SignInState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.changeData = false,
    this.username,
    this.password,
    this.passwordAgain,
  });

  @override
  List<Object?> get props => [
    loadDataStatus,
    saveStatus,
    changeData,
    username,
    password,
    passwordAgain,
      ];

  SignInState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    bool? changeData,
    String? username,
    String? password,
    String? passwordAgain,
  }) {
    return SignInState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      changeData: changeData ?? this.changeData,
      username: username ?? this.username,
      password: password ?? this.password,
      passwordAgain: passwordAgain ?? this.passwordAgain,
    );
  }
}
