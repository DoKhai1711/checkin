import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/visited.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';

part 'statistical_state.dart';

class StatisticalCubit extends Cubit<StatisticalState> {
  StatisticalCubit() : super(const StatisticalState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls
      Map<String, dynamic>? profile = {};

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constant.USER_NAME) ?? '';

      int totalMoney = 0;

      db.child('acc/$username').once().then((snapshot) {
        profile = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);

        List<Visited> listHistory = [];
        if (profile![Constant.HISTORY] != null) {
          profile![Constant.HISTORY].forEach((key, value) {
            final map = Map<String, dynamic>.from(value);
            Visited item = Visited.fromJson(map);
            totalMoney += item.money??0;
            listHistory.add(item);
          });
        }

        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            profile: profile,
            username: username,
            listHistory: listHistory,
            totalMoney: totalMoney,
          ),
        );
      });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
