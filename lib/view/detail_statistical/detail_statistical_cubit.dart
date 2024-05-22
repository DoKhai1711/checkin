import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/visited.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';

part 'detail_statistical_state.dart';

class DetailStatisticalCubit extends Cubit<DetailStatisticalState> {
  DetailStatisticalCubit() : super(const DetailStatisticalState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData({
    required String accountInfo,
  }) async {
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls
      Map<String, dynamic>? listMap = {};

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constant.USER_NAME) ?? '';

      int totalMoney = 0;

      db.child('acc').once().then((snapshot) {
        listMap = Map<String, dynamic>.from(
            (snapshot as dynamic).snapshot.value as dynamic);

        Map<String, dynamic>? profileUser =
            Map<String, dynamic>.from(listMap![username]);

        Map<String, dynamic>? profile =
            Map<String, dynamic>.from(listMap![accountInfo]);

        List<Visited> listHistory = [];
        if (profileUser[Constant.TYPE] == Constant.CUSTOMER) {
          if (profileUser[Constant.HISTORY_EMPLOYEE]?[accountInfo] != null) {
            profileUser[Constant.HISTORY_EMPLOYEE]?[accountInfo]
                .forEach((key, value) {
              final map = Map<String, dynamic>.from(value);
              Visited item = Visited.fromJson(map);
              totalMoney += item.money ?? 0;
              listHistory.add(item);
            });
          }
        } else {
          if (profileUser[Constant.HISTORY_CUSTOMER]?[accountInfo] != null) {
            profileUser[Constant.HISTORY_CUSTOMER]?[accountInfo]
                .forEach((key, value) {
              final map = Map<String, dynamic>.from(value);
              Visited item = Visited.fromJson(map);
              totalMoney += item.money ?? 0;
              listHistory.add(item);
            });
          }
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
