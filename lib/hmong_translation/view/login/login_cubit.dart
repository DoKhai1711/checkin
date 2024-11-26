import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/login/login_dto.dart';
import 'package:untitled/hmong_translation/model/login/login_request_dto.dart';
import 'package:untitled/hmong_translation/service/service.dart';
import 'package:untitled/utils/enum.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final MyAppService _service = MyAppServiceImp();

  LoginCubit() : super(const LoginState());

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

  Future<void> onLogin(
      {required String email, required String password}) async {
    try {
      emit(state.copyWith(saveStatus: LoadStatus.loading));
      LoginRequestDto request = LoginRequestDto(
        email: email,
        password: password,
      );

      final result = await _service.login(request: request);

      if (result.data != null) {
        emit(
          state.copyWith(
            saveStatus: LoadStatus.success,
            loginResponse: result.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            saveStatus: LoadStatus.failure,
            message: result.error,
          ),
        );
      }
    } catch (e) {
      //Todo: should print exception here
      emit(
        state.copyWith(
          saveStatus: LoadStatus.failure,
          message: "Có lỗi xảy ra",
        ),
      );
    }
  }
}
