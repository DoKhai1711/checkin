import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/utils/enum.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {

  SignInCubit() : super(const SignInState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void onChangeData({
    String? usernameInput,
    String? passwordInput,
    String? passwordAgainInput,
  }) {
    String? username = state.username;
    String? password = state.password;
    String? passwordAgain = state.passwordAgain;

    if (usernameInput != null) {
      username = usernameInput;
    }

    if (passwordInput != null) {
      password = passwordInput;
    }

    if (passwordAgainInput != null) {
      passwordAgain = passwordAgainInput;
    }

    emit(
      state.copyWith(
        username: username,
        password: password,
        passwordAgain: passwordAgain,
      ),
    );
  }

  String validate() {
    String result = "";
    if ((state.username ?? '').isEmpty) {
      result = "Tên đăng nhập không được để trống";
    }
    if ((state.password ?? '').isEmpty) {
      result = "Mật khẩu không được để trống";
    }
    if ((state.passwordAgain ?? '').isEmpty) {
      result = "Nhập lại mật khẩu không được để trống";
    }
    if (state.passwordAgain != state.passwordAgain) {
      result = "Nhập lại mật khẩu phải giống với mật khẩu đã nhập";
    }
    return result;
  }

  Future<void> onSave() async {
    try {
      emit(state.copyWith(saveStatus: LoadStatus.loading));

      emit(state.copyWith(saveStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(saveStatus: LoadStatus.failure));
    }
  }

}
