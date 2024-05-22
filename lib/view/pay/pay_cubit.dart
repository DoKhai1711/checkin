import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/date_utils.dart';
import 'package:untitled/utils/enum.dart';

part 'pay_state.dart';

class PayCubit extends Cubit<PayState> {
  PayCubit() : super(const PayState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constant.USER_NAME) ?? '';

      db.once().then((snapshot) {
        Map<String, dynamic> database = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);
        Map<String, dynamic> listAccount =
            Map<String, dynamic>.from(database[Constant.ACCOUNT]);
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            listAccount: listAccount,
            username: username,
          ),
        );
      });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void onChangeData({
    String? moneyInput,
  }) {
    String? money = state.money;

    if (moneyInput != null) {
      money = moneyInput;
    }

    emit(
      state.copyWith(
        money: money,
      ),
    );
  }

  String validate() {
    String result = "";
    if ((state.money ?? '').isEmpty) {
      result = "Tiền tri ân không được để trống";
    } else if (int.parse(state.money!)>state.listAccount![state.username!][Constant.MONEY]){
      result = "Số tiền tri ân vượt quá số tiền hiện tại đang có";
    }

    return result;
  }

  Future<void> onSave({
    required String customer,
  }) async {
    try {
      emit(state.copyWith(saveStatus: LoadStatus.loading));

      ///trừ tiền tk chủ cửa hàng
      await db
          .child(Constant.ACCOUNT)
          .child(state.username!)
          .update(<String, dynamic>{
        Constant.MONEY: state.listAccount![state.username!][Constant.MONEY] -
            int.parse(state.money!),
      });

      ///Tạo lịch sử theo khách hàng
      await db
          .child(Constant.ACCOUNT)
          .child(state.username!)
          .child(Constant.HISTORY_CUSTOMER)
          .child(customer)
          .push()
          .set(<String, dynamic>{
        Constant.MONEY: int.parse(state.money!),
        Constant.CREATE_DATE: ConvertDate.convertDateTimeToStr(
          date: DateTime.now(),
          type: ConvertDate.dateTimeNormalFull,
        ),
      });

      ///Tạo danh sách lịch sử
      await db
          .child(Constant.ACCOUNT)
          .child(state.username!)
          .child(Constant.HISTORY)
          .push()
          .set(<String, dynamic>{
        Constant.USERNAME: customer,
        Constant.NAME: state.listAccount![customer][Constant.NAME],
        Constant.PHONE: state.listAccount![customer][Constant.PHONE],
        Constant.ADDRESS: state.listAccount![customer][Constant.ADDRESS],
        Constant.MONEY: int.parse(state.money!),
        Constant.CREATE_DATE: ConvertDate.convertDateTimeToStr(
          date: DateTime.now(),
          type: ConvertDate.dateTimeNormalFull,
        ),
      });

      ///Tạo lich su ghé thăm lần cuối
      await db.child("${Constant.ACCOUNT}/${state.username}").update({
        Constant.LAST_VISITED: {
          Constant.USERNAME: customer,
          Constant.NAME: state.listAccount![customer][Constant.NAME],
          Constant.PHONE: state.listAccount![customer][Constant.PHONE],
          Constant.ADDRESS: state.listAccount![customer][Constant.ADDRESS],
          Constant.MONEY: int.parse(state.money!),
          Constant.CREATE_DATE: ConvertDate.convertDateTimeToStr(
            date: DateTime.now(),
            type: ConvertDate.dateTimeNormalFull,
          ),
        }
      });

      ///Cộng tiền tài khoản khách hàng
      await db.child(Constant.ACCOUNT).child(customer).update({
        Constant.MONEY: state.listAccount![customer][Constant.MONEY] +
            int.parse(state.money!),
      });

      ///Tạo lịch sử theo chủ cửa hàng
      await db
          .child(Constant.ACCOUNT)
          .child(customer)
          .child(Constant.HISTORY_EMPLOYEE)
          .child(state.username!)
          .push()
          .set(<String, dynamic>{
        Constant.MONEY: int.parse(state.money!),
        Constant.CREATE_DATE: ConvertDate.convertDateTimeToStr(
          date: DateTime.now(),
          type: ConvertDate.dateTimeNormalFull,
        ),
      });

      ///Tạo danh sách lịch sử
      await db
          .child(Constant.ACCOUNT)
          .child(customer)
          .child(Constant.HISTORY)
          .push()
          .set(<String, dynamic>{
        Constant.USERNAME: state.username,
        Constant.NAME: state.listAccount![state.username][Constant.NAME],
        Constant.PHONE: state.listAccount![state.username][Constant.PHONE],
        Constant.ADDRESS: state.listAccount![state.username][Constant.ADDRESS],
        Constant.MONEY: int.parse(state.money!),
        Constant.CREATE_DATE: ConvertDate.convertDateTimeToStr(
          date: DateTime.now(),
          type: ConvertDate.dateTimeNormalFull,
        ),
      });

      ///Tạo lịch sử ghé thăm lần cuối
      await db.child("${Constant.ACCOUNT}/$customer").update({
        Constant.LAST_VISITED: {
          Constant.USERNAME: state.username,
          Constant.NAME: state.listAccount![state.username][Constant.NAME],
          Constant.PHONE: state.listAccount![state.username][Constant.PHONE],
          Constant.ADDRESS: state.listAccount![state.username]
              [Constant.ADDRESS],
          Constant.MONEY: int.parse(state.money!),
          Constant.CREATE_DATE: ConvertDate.convertDateTimeToStr(
            date: DateTime.now(),
            type: ConvertDate.dateTimeNormalFull,
          ),
        }
      });

      emit(state.copyWith(saveStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(saveStatus: LoadStatus.failure));
    }
  }
}
