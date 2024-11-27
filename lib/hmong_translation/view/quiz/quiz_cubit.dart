import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/question/group_question.dart';
import 'package:untitled/hmong_translation/service/service.dart';
import 'package:untitled/utils/enum.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final MyAppService _service = MyAppServiceImp();
  QuizCubit() : super(const QuizState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {

      final result = await _service.getListGroupQuest();
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.success,
          data: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.failure,
          data: [],
        ),
      );
    }
  }
}
