import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(const CreateAccountState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls

      db.once().then((snapshot) {
        Map<String, dynamic> database = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);
        Map<String, dynamic> listPhoneNumber =
            Map<String, dynamic>.from(database[Constant.PHONE_NUMBER]);
        Map<String, dynamic> listAccount =
            Map<String, dynamic>.from(database[Constant.ACCOUNT]);
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            listAccount: listAccount,
            listPhoneNumber: listPhoneNumber,
          ),
        );
      });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void onChangeData({
    String? usernameInput,
    String? passwordInput,
    String? addressInput,
    String? phoneInput,
    String? nameInput,
  }) {
    String? username = state.username;
    String? password = state.password;
    String? address = state.address;
    String? phone = state.phone;
    String? name = state.name;

    if (usernameInput != null) {
      username = usernameInput;
    }

    if (passwordInput != null) {
      password = passwordInput;
    }

    if (nameInput != null) {
      name = nameInput;
    }

    if (addressInput != null) {
      address = addressInput;
    }

    if (phoneInput != null) {
      phone = phoneInput;
    }

    emit(
      state.copyWith(
        username: username,
        password: password,
        name: name,
        address: address,
        phone: phone,
      ),
    );
  }

  String validate() {
    String result = "";
    if ((state.username ?? '').isEmpty) {
      result = "Tên đăng nhập không được để trống";
    } else if (state.listAccount![state.username] != null) {
      result = "Tên đăng nhập đã đuợc đăng ký";
    }
    if ((state.password ?? '').isEmpty) {
      result = "Mật khẩu không được để trống";
    }
    if ((state.address ?? '').isEmpty) {
      result = "Địa chỉ không được để trống";
    }
    if ((state.phone ?? '').isEmpty) {
      result = "Số điện thoại không được để trống";
    } else if (state.phone!.length != 10) {
      result = "Số điện thoại phải gồm 10 chữ số";
    } else if (state.listPhoneNumber![state.phone] != null) {
      result = "Số điện thoại đã đuợc đăng ký";
    }
    return result;
  }

  Future<void> onSave() async {
    try {
      emit(state.copyWith(saveStatus: LoadStatus.loading));

      await db.child(Constant.ACCOUNT).update({
        state.username!: {
          Constant.PASS: state.password,
          Constant.PHONE: state.phone,
          Constant.ADDRESS: state.address,
          Constant.TYPE: state.type,
          Constant.NAME: state.name,
          Constant.MONEY: 0,
          Constant.SCORE: 0,
        }
      });

      await db.child(Constant.PHONE_NUMBER).update({
        state.phone!: "",
      });

      emit(state.copyWith(saveStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(saveStatus: LoadStatus.failure));
    }
  }

  void changeType(String type) {
    emit(
      state.copyWith(
        changeData: !state.changeData,
        type: type,
      ),
    );
  }

}
