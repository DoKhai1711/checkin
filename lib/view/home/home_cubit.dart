import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

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

  void onChangeData() async {

    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String username = sharedPreferences.getString(Constant.USER_NAME) ?? '';

    db.child('acc/$username').onValue.listen((DatabaseEvent event) {
      Map<String, dynamic>? profile = {};
      profile = Map<String, dynamic>.from(
          (event as dynamic).snapshot.value as dynamic);
      try {
        emit(
          state.copyWith(
            profile: profile,
            changeData: !state.changeData,
          ),
        );
      } catch (e) {}
    });
  }

  void changeIsShowMoney() {
    emit(
      state.copyWith(
        isShowMoney: !state.isShowMoney,
      ),
    );
  }

  void setCustomerNow(String account) async {
    await db.child(Constant.ACCOUNT).child(state.username!).update({
      "customerNow": account,
    });
  }

}
