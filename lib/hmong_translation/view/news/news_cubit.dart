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
      List<NewsDto> list = [];
      list.add(NewsDto(
        id: 0,
        title: "Học tiếng Hmong cấp tốc. Phần 1",
        description: "Học hỏi tiêng Hmong vùng cao..... # cho những người thích đi giao lưu với người Hmong..... # học những từ cơ bản.",
        url: "https://www.youtube.com/watch?v=cHnVDheT894&list=PLa6RRAPhRoH2c67Jzc79Qqq5dOUVjvkgq&ab_channel=Txoojsawmhaam",
        urlToImage: "https://eholiday.vn/wp-content/uploads/2021/07/doc-dao-net-van-hoa-cua-nguoi-hmong-tai-sapa-1.jpg",
        time: "10 phút 08 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học tiếng hmong cấp tốc - phần 2",
          description: "Đây là video dành cho những bạn nào yêu thích khám phá, học hỏi về tiếng hmong và thích sống chung với những người đồng bào dân tộc hmong trên miền núi..",
          url: "https://www.youtube.com/watch?v=23g3gPrW6dg&list=PLa6RRAPhRoH2c67Jzc79Qqq5dOUVjvkgq&index=2&ab_channel=Txoojsawmhaam",
          urlToImage: "https://eholiday.vn/wp-content/uploads/2021/07/doc-dao-net-van-hoa-cua-nguoi-hmong-tai-sapa-3.jpg",
          time: "12 phút 11 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học tiếng hmong cấp tốc phần 3 - tình yêu và cảm xúc. @",
          description: "Video này phù hợp cho các giới trẻ và đặc biệt là các bạn nam nữ nào mà đang yêu đương...❤❤... Chúc các bạn thành công trên đường đi tìm người yêu nhé.",
          url: "Đây là video dành cho những bạn nào yêu thích khám phá, học hỏi về tiếng hmong và thích sống chung với những người đồng bào dân tộc hmong trên miền núi.",
          urlToImage: "https://eholiday.vn/wp-content/uploads/2021/07/doc-dao-net-van-hoa-cua-nguoi-hmong-tai-sapa-4.jpg",
          time: "08 phút 24 giây"
      ));
      list.add(NewsDto(
          id: 0,
          title: "Học tiếng Hmong cấp tốc - phần 4",
          description: "Về thực phẩm thì còn rất nhiều thứ, nhưng mình chỉ đưa ra vài thứ cơ bản. Còn thắc mắc gì xin các bạn viết ý kiến của mình dưới binh luận, để mình biết và bổ sung thêm cho những gì các bạn cần biết nha.",
          url: "https://www.youtube.com/watch?v=94--6E_ueXA&list=PLa6RRAPhRoH2c67Jzc79Qqq5dOUVjvkgq&index=4&ab_channel=Txoojsawmhaam",
          urlToImage: "https://eholiday.vn/wp-content/uploads/2021/07/doc-dao-net-van-hoa-cua-nguoi-hmong-tai-sapa-7.jpg",
          time: "15 phút 37 giây"
      ));

      emit(state.copyWith(loadDataStatus: LoadStatus.success, listData: list));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
