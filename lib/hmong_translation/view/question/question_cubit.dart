import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/question/group_question.dart';
import 'package:untitled/hmong_translation/service/service.dart';
import 'package:untitled/utils/enum.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final MyAppService _service = MyAppServiceImp();
  QuestionCubit() : super(const QuestionState());

  Future<void> loadInitialData({
    required int id,
}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {

      final result = await _service.getGroupQuest(id: id);
      if (result.data != null) {
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.success,
            data: result.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loadDataStatus: LoadStatus.failure,
            message: result.error,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.failure,
          message: "Có lỗi xảy ra",
        ),
      );
    }
  }

  void onAnswer({
    required int answerIndex
}) {
    emit(
      state.copyWith(
        changeData: !state.changeData,
        hasAnswered: true,
        answerIndex: answerIndex,
      ),
    );
  }

  void nextQuest() {
    emit(
      state.copyWith(
        index: state.index+1,
        changeData: !state.changeData,
        hasAnswered: false,
      ),
    );
  }
}
