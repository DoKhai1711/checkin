import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/login/sign_in_request.dart';
import 'package:untitled/hmong_translation/service/service.dart';
import 'package:untitled/utils/enum.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final MyAppService _service = MyAppServiceImp();

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
    String? emailInput,
  }) {
    String? username = state.username;
    String? password = state.password;
    String? passwordAgain = state.passwordAgain;
    String? email = state.email;

    if (usernameInput != null) {
      username = usernameInput;
    }

    if (passwordInput != null) {
      password = passwordInput;
    }

    if (passwordAgainInput != null) {
      passwordAgain = passwordAgainInput;
    }

    if (emailInput != null) {
      email = emailInput;
    }

    emit(
      state.copyWith(
        username: username,
        password: password,
        passwordAgain: passwordAgain,
        email: email,
      ),
    );
  }

  String validate() {
    String result = "";
    if ((state.username ?? '').isEmpty) {
      result = "Họ và tên không được để trống";
    }
    if ((state.email ?? '').isEmpty) {
      result = "Email không được để trống";
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
      SignInRequest request = SignInRequest(
        email: state.email,
        username: state.username,
        password: state.password,
      );

      final result = await _service.register(request: request);

      if (result.isEmpty) {
        emit(
          state.copyWith(
            saveStatus: LoadStatus.success,
            message: "Tạo tài khoản thành công",
          ),
        );
      } else {
        emit(
          state.copyWith(
            saveStatus: LoadStatus.failure,
            message: result,
          ),
        );
      }
    } catch (e) {
      //Todo: should print exception here
      emit(
        state.copyWith(
          saveStatus: LoadStatus.failure,
          message: "Có lỗi xảy ra hàm tạo tài khoản",
        ),
      );
    }
  }

}
