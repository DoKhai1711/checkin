import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/translate/translate_request.dart';
import 'package:untitled/hmong_translation/service/service.dart';
import 'package:untitled/utils/enum.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final MyAppService _service = MyAppServiceImp();

  TranslateCubit() : super(const TranslateState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void changeTypeTranslate() {
    emit(
      state.copyWith(
        changeData: !state.changeData,
        isHmongToViet: !state.isHmongToViet,
      ),
    );
  }

  Future<void> onTranslate({
    required String text,
  }) async {
    try {
      if (text.isEmpty) {
        emit(
          state.copyWith(
            changeData: !state.changeData,
            toText: "",
          ),
        );
      } else {
        emit(
          state.copyWith(
              changeData: !state.changeData,
              toText: "..."
          ),
        );
        TranslateRequestDto request = TranslateRequestDto(
          text: text,
          source_lang: state.isHmongToViet ? 'mong' : 'viet',
          target_lang: state.isHmongToViet ? 'viet' : 'mong',
        );

        final result = await _service.translate(request: request);

        emit(
          state.copyWith(
            changeData: !state.changeData,
            toText: result,
          ),
        );
      }
    } catch (e) {
      //Todo: should print exception here
      emit(
        state.copyWith(
          changeData: !state.changeData,
          toText: "Có lỗi xảy ra hàm xử lý",
        ),
      );
    }
  }

}
