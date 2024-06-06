import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/view/main_page.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls
      Map<String, dynamic>? listAcc = {};

      db.child(Constant.ACCOUNT).onValue.listen((snapshot) {
        listAcc = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);
        try {
          emit(
            state.copyWith(
              loadDataStatus: LoadStatus.success,
              listAcc: listAcc,
            ),
          );
        } catch (e) {

        }
      });

      // db.child('acc').onValue.listen((DatabaseEvent event) {
      //   listAcc = Map<String, dynamic>.from(
      //       (event as dynamic).snapshot.value as dynamic);
      // });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<String> check() async {
    try {
      if ((state.username ?? '').isEmpty) {
        return "Bạn chưa nhập Tên đăng nhập";
      }
      if ((state.password ?? '').isEmpty) {
        return "Bạn chưa nhập Mật khẩu";
      }
      if (state.listAcc?[state.username]?[Constant.PASS] == state.password) {

        if (state.listAcc?[state.username][Constant.TYPE] == Constant.EMPLOYEE) {
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString(
            Constant.USER_NAME,
            state.username ?? '',
          );
          return "";
        } else {
          return "Tên đăng nhập hoặc mật khẩu không đúng";
        }
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

  void changePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainPage(
          type: state.listAcc![state.username]
          [Constant.TYPE],
        ),
      ),
    );
  }
}
