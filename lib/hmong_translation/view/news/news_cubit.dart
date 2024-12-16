import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/news/newsDto.dart';
import 'package:untitled/utils/enum.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {

  NewsCubit() : super(const NewsState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      // final pdfData = await loadPdfFromAssets("assets/gramma.pdf");
      List<NewsDto> list = [];
      list.add(NewsDto(
        id: 0,
        title: "Học từ vựng tiếng Mông - Chủ đề: Màu sắc",
        description: "Học hỏi tiêng Hmong vùng cao..... # cho những người thích đi giao lưu với người Hmong..... # học những từ cơ bản.",
        url: "https://www.youtube.com/watch?v=Q4CzU1sXGI4&ab_channel=LaoCaiNo1",
        urlToImage: "https://tuyenquang.dcs.vn/Image/Large/202242710290_89379.jpg",
        time: "1 phút 09 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học từ vựng tiếng Mông - Chủ đề: Đồ vật",
          description: "Video này phù hợp cho các giới trẻ và đặc biệt là các bạn nam nữ nào mà đang yêu đương...❤❤... Chúc các bạn thành công trên đường đi tìm người yêu nhé.",
          url: "https://www.youtube.com/watch?v=NYCXIEMIOKc&ab_channel=LaoCaiNo1",
          urlToImage: "https://media.istockphoto.com/id/1457277458/vi/vec-to/b%E1%BB%99-vector-3d-c%E1%BB%A7a-b%C3%A3i-bi%E1%BB%83n-v%C3%A0-bi%E1%BB%83n-h%C3%A0nh-tr%C3%ACnh-m%C3%B9a-h%C3%A8-kh%C3%A1i-ni%E1%BB%87m-th%E1%BB%9Di-gian-%C4%91%E1%BB%83-du-l%E1%BB%8Bch.jpg?s=2048x2048&w=is&k=20&c=oAiHWCVMpoNCLMGa7GYZhYMzzd6rAylfPjcMOuuZPdg=",
          time: "1 phút 39 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học từ vựng tiếng Mông - Chủ đề: Hoa quả",
          description: "Về thực phẩm thì còn rất nhiều thứ, nhưng mình chỉ đưa ra vài thứ cơ bản. Còn thắc mắc gì xin các bạn viết ý kiến của mình dưới binh luận, để mình biết và bổ sung thêm cho những gì các bạn cần biết nha.",
          url: "https://www.youtube.com/watch?v=7poo9lR1358&ab_channel=LaoCaiNo1",
          urlToImage: "https://hoaquafuji.com/storage/app/media/anh-sua/hoa-qua-huu-co-2.jpg",
          time: "1 phút 06 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học từ vựng tiếng Mông thông qua tiểu phầm",
          description: "Đây là video dành cho những bạn nào yêu thích khám phá, học hỏi về tiếng hmong và thích sống chung với những người đồng bào dân tộc hmong trên miền núi..",
          url: "https://www.youtube.com/watch?v=uwHswWFh6wM&ab_channel=LaoCaiNo1",
          urlToImage: "https://eholiday.vn/wp-content/uploads/2021/07/doc-dao-net-van-hoa-cua-nguoi-hmong-tai-sapa-7.jpg",
          time: "1 phút 03 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học từ vựng tiếng Mông - Chủ đề: Con vật",
          description: "Học hỏi tiêng Hmong vùng cao..... # cho những người thích đi giao lưu với người Hmong..... # học những từ cơ bản.",
          url: "https://www.youtube.com/watch?v=qBYHa_1iQnc&ab_channel=LaoCaiNo1",
          urlToImage: "https://mediabls.mediatech.vn/upload/image/202010/medium/190773_2-3.jpg",
          time: "1 phút 24 giây"
      ));

      emit(state.copyWith(loadDataStatus: LoadStatus.success, listData: list));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<Uint8List> loadPdfFromAssets(String assetPath) async {
    // Load the PDF from assets and return the file path
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    return bytes;
  }
}
