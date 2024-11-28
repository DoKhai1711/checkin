class TranslateRequestDto {
  String? text;
  String? source_lang;
  String? target_lang;

  TranslateRequestDto({this.text, this.source_lang, this.target_lang});

  TranslateRequestDto.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    source_lang = json['source_lang'];
    target_lang = json['target_lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['source_lang'] = source_lang;
    data['target_lang'] = target_lang;
    return data;
  }
}
