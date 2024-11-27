part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final bool changeData;
  final String? username;
  final String? email;
  final String? password;
  final String? passwordAgain;
  final String? message;

  const SignInState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.changeData = false,
    this.username,
    this.email,
    this.password,
    this.passwordAgain,
    this.message,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        saveStatus,
        changeData,
        username,
        email,
        password,
        passwordAgain,
        message,
      ];

  SignInState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    bool? changeData,
    String? username,
    String? email,
    String? password,
    String? passwordAgain,
    String? message,
  }) {
    return SignInState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      changeData: changeData ?? this.changeData,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordAgain: passwordAgain ?? this.passwordAgain,
      message: message ?? this.message,
    );
  }
}
