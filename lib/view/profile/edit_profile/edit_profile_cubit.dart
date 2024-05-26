import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());

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
        Map<String, dynamic> profile =
            Map<String, dynamic>.from(database[Constant.ACCOUNT][username]);
        Map<String, dynamic> listPhoneNumber =
            Map<String, dynamic>.from(database[Constant.PHONE_NUMBER]);
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            profile: profile,
            username: username,
            password: profile[Constant.PASS],
            address: profile[Constant.ADDRESS],
            phone: profile[Constant.PHONE],
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
    String? passwordInput,
    String? addressInput,
    String? phoneInput,
  }) {
    String? password = state.password;
    String? address = state.address;
    String? phone = state.phone;

    if (passwordInput != null) {
      password = passwordInput;
    }

    if (addressInput != null) {
      address = addressInput;
    }

    if (phoneInput != null) {
      phone = phoneInput;
    }

    emit(
      state.copyWith(
        password: password,
        address: address,
        phone: phone,
      ),
    );
  }

  String validate() {
    String result = "";
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
    } else if (state.listPhoneNumber![state.phone] != null &&
        state.phone != state.profile![Constant.PHONE]) {
      result = "Số điện thoại đã đuợc đăng ký";
    }
    return result;
  }

  Future<void> onSave() async {
    try {
      emit(state.copyWith(saveStatus: LoadStatus.loading));

      await db.child('${Constant.ACCOUNT}/${state.username}').update({
        Constant.PASS: state.password,
        Constant.PHONE: state.phone,
        Constant.ADDRESS: state.address,
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
}
