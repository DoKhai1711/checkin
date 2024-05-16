import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/utils/enum.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      Map<String, dynamic>? listAcc = {};
      db.child('acc').onValue.listen((DatabaseEvent event) {
        listAcc = Map<String, dynamic>.from(
            (event as dynamic).snapshot.value as dynamic);
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            listAcc: listAcc,
          ),
        );
      });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  String check() {
    try {
      if ((state.username ?? '').isEmpty) {
        return "Bạn chưa nhập Tên đăng nhập";
      }
      if ((state.password ?? '').isEmpty) {
        return "Bạn chưa nhập Mật khẩu";
      }
      if (state.listAcc?[state.username]["pass"] == state.password) {
        return "";
      } else {
        return "Tên đăng nhập hoặc mật khẩu không đúng";
      }
    } catch (e) {
      return "Có lỗi xảy ra, vui lòng liên hệ kỹ thuật viên";
    }
  }

  void inputAcc({
    String? username,
    String? password,
  }) {
    if (username != null) {
      emit(
        state.copyWith(
          username: username,
        ),
      );
    }
    if (password != null) {
      emit(
        state.copyWith(
          password: password,
        ),
      );
    }
  }
}
