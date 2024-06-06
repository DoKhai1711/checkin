import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/visited.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/enum.dart';

part 'home_web_state.dart';

class HomeWebCubit extends Cubit<HomeWebState> {
  HomeWebCubit() : super(const HomeWebState());

  final db = FirebaseDatabase.instance.ref();

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      //Todo: add API calls
      Map<String, dynamic>? listMap = {};

      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constant.USER_NAME) ?? '';

      int totalMoney = 0;

      db.child('acc').onValue.listen((snapshot) {
        try {

          emit(state.copyWith(loadDataStatus: LoadStatus.loading));

          listMap = Map<String, dynamic>.from(
              (snapshot as dynamic).snapshot.value as dynamic);

          Map<String, dynamic>? profileUser =
          Map<String, dynamic>.from(listMap![username]);

          String? accountInfo = profileUser['customerNow'];

          if (accountInfo==null) {
            emit(
              state.copyWith(
                loadDataStatus: LoadStatus.failure,
              ),
            );
            return;
          }

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
        } catch (e) {
          return;
        }
      });
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
