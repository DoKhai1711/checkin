import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/show_message.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(const WalletState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls
      Map<String, dynamic>? profile = {};

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constant.USER_NAME) ?? '';

      db.child('acc/$username').once().then((snapshot) {
        profile = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            profile: profile,
            username: username,
          ),
        );
      });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void setRechargeType() {
    emit(
      state.copyWith(
        type: Constant.RECHARGE,
      ),
    );
  }

  void setWithDrawType() {
    emit(
      state.copyWith(
        type: Constant.WITHDRAW,
      ),
    );
  }

  void changeMoney({
    required String money,
    required String name,
    required String stk,
  }) async {
    try {
      emit(state.copyWith(saveStatus: LoadStatus.loading));

      if (name.isEmpty) {
        showToast(
          message: "Bạn chưa nhập tên chủ tài khoản ngân hàng",
          color: Colors.red,
        );
      } else if (stk.isEmpty) {
        showToast(
          message: "Bạn chưa nhập số tài khoản",
          color: Colors.red,
        );
      } else if (money.isEmpty) {
        showToast(
          message: "Bạn chưa nhập số tiền",
          color: Colors.red,
        );
      }

      int moneyNumber = int.parse(money);

      if (state.type == Constant.WITHDRAW) {
        if (state.profile!['money'] - moneyNumber < 0) {
          showToast(
            message: "Số tiền rút vượt quá số tiền trong ví",
            color: Colors.red,
          );
        } else {
          await db.child('${Constant.ACCOUNT}/${state.username}').update({
            Constant.MONEY: state.profile!['money'] - moneyNumber,
          });
        }
      } else if (state.type == Constant.RECHARGE) {
        await db.child('${Constant.ACCOUNT}/${state.username}').update({
          Constant.MONEY: state.profile!['money'] + moneyNumber,
        });
      }
      Map<String, dynamic>? profile = {};

      db.child('${Constant.ACCOUNT}/${state.username}').once().then((snapshot) {
        profile = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);
        emit(
          state.copyWith(
            saveStatus: LoadStatus.success,
            profile: profile,
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(saveStatus: LoadStatus.failure));
    }
  }
}
