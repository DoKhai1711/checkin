part of 'translate_cubit.dart';

class TranslateState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus translateStatus;
  final bool isHmongToViet;
  final bool changeData;
  final String fromText;
  final String toText;

  const TranslateState({
    this.loadDataStatus = LoadStatus.initial,
    this.translateStatus = LoadStatus.initial,
    this.isHmongToViet = true,
    this.changeData = true,
    this.fromText = "",
    this.toText = "",
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        translateStatus,
        isHmongToViet,
        changeData,
        fromText,
        toText,
      ];

  TranslateState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? translateStatus,
    bool? isHmongToViet,
    bool? changeData,
    String? fromText,
    String? toText,
  }) {
    return TranslateState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      translateStatus: translateStatus ?? this.translateStatus,
      isHmongToViet: isHmongToViet ?? this.isHmongToViet,
      changeData: changeData ?? this.changeData,
      fromText: fromText ?? this.fromText,
      toText: toText ?? this.toText,
    );
  }
}
