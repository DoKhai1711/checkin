import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/hmong_translation/model/news/newsDto.dart';
import 'package:untitled/utils/enum.dart';
part 'culture_state.dart';

class CultureCubit extends Cubit<CultureState> {


  CultureCubit() : super(const CultureState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.loading));
      List<NewsDto> list = [];
      list.add(NewsDto(
          id: 0,
          title: "Người H’Mông Lào Cai Cùng Tìm Hiểu Phong Tục Và Văn Hóa",
          description: "Người H’Mông Lào Cai Cùng Tìm Hiểu Phong Tục Và Văn Hóa. Đến với Tây Bắc,du khách có thể khám phá các vẻ đẹp hoang sơ, kỳ vĩ của thiên nhiên ban tặng, ngoài ra còn có thể hòa mình vào cuộc sống của những con người dân tộc nơi đây. Đó là một trải nghiệm thực sự thú vị phải không nào?",
          url: "http://thuexemaylaocai.com/nguoi-hmong-lao-cai/",
          urlToImage: "http://thuexemaylaocai.com/wp-content/uploads/2017/10/nguoi-hmong-lao-cai.jpg",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "VÀI NÉT VỀ VĂN HÓA CỦA DÂN TỘC H’MÔNG Ở VIỆT NAM",
          description: "Nằm trong một quốc gia đa dân tộc, dân tộc H’mông được coi là một thành viên quan trọng trong cộng đồng các dân tộc thiểu số ở Việt Nam. Cùng với 53 dân tộc anh em, người H’mông luôn là một phần của sự thống nhất khối đại đoàn kết dân tộc và góp phần làm phong phú cho nền văn hóa các dân tộc Việt Nam.",
          url: "https://baotangphunu.com/vai-net-ve-van-hoa-cua-dan-toc-hmong-o-viet-nam/",
          urlToImage: "https://i0.wp.com/baotangphunu.com/wp-content/uploads/2022/08/slide-1.jpg?resize=1400%2C785&ssl=1",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "Nét đẹp trong phong tục, tập quán văn hóa của người Mông",
          description: "Dân tộc Mông sống chủ yếu ở vùng núi cao. Đồng bào Mông trên cả nước nói chung, Yên Bái nói riêng có lối sống giản dị, mộc mạc nhưng bảo lưu được nhiều phong tục, tập quán văn hóa truyền thống độc đáo.",
          url: "https://baodantoc.vn/net-dep-trong-phong-tuc-tap-quan-van-hoa-cua-nguoi-mong-1650622165522.htm",
          urlToImage: "https://images.baodantoc.vn/uploads/2022/Th%C3%A1ng%204/Ng%C3%A0y_22/Anh/untitled%20folder%201/ruong-bac-thang-mu-cang-chai-1.jpg",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "Văn hóa người H’mong, những điều chưa kể",
          description: "Trong chương trình Văn hóa Nghệ thuật tuần này mời quý vị cùng với chúng tôi tìm hiểu một vài khía cạnh văn hóa của đồng bào H’mong tại Việt Nam với những điều có thể nhiều người vẫn hiểu lầm về sinh hoạt truyền thống đặc sắc của họ. ",
          url: "https://www.rfa.org/vietnamese/news/programs/LiteratureAndArts/the-culture-of-h-mong-untold-stories-ml-04092016083105.html",
          urlToImage: "https://www.rfa.org/vietnamese/news/programs/LiteratureAndArts/the-culture-of-h-mong-untold-stories-ml-04092016083105.html/000_Hkg9914178-622.jpg/@@images/9dfe7b79-1967-4b82-95f3-74f7c54036d2.jpeg",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "Người H'Mông với trang phục truyền thống",
          description: "Người H'Mông (RPA: Hmoob/Moob; phát âm: m̥ɔ̃ŋ hay H'Mông), là một nhóm dân tộc có địa bàn cư trú truyền thống là Trung Quốc và các nước lân cận thuộc tiểu vùng Đông Nam Á là Lào, Việt Nam, Thái Lan và Myanmar. Một trong những đặc sắc văn hóa của dân tộc này chính là nghệ thuật trang phục.",
          url: "https://www.vanhoa.vn/2017/09/nguoi-hmong-voi-trang-phuc-truyen-thong.html",
          urlToImage: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgbDyGrXkPvH36U6EPRVHtLPvQLlnl_M35H1sCwh9M2hcTU-AY4GOUQUCiLP9uhzFbzA5UaPl1DGQehi6spJHx4UxuaB6kXWkYL_IoXeO8_BLWPxgWt9AF-HcWZQZHXjkPG_CE5EM0Hkecc/s400/Trang-ph%25E1%25BB%25A5c-truy%25E1%25BB%2581n-th%25E1%25BB%2591ng-c%25E1%25BB%25A7a-d%25C3%25A2n-t%25E1%25BB%2599c-h%25E2%2580%2599mong.jpg",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "Hội Gầu Tào – sự kiện văn hóa đặc trưng của người H’Mông",
          description: "Nằm trong một quốc gia đa dân tộc như nước ta; dân tộc H’mông được coi là một thành viên vô cùng quan trọng trong cộng đồng các dân tộc thiểu số ở Việt Nam. Cùng với 53 dân tộc anh em khác, người H’mông luôn là một phần của sự thống nhất trong khối đại đoàn kết dân tộc và góp phần làm phong phú thêm cho nền văn hóa các dân tộc Việt Nam.",
          url: "https://vfs.vn/hoi-gau-tao-su-kien-van-hoa-dac-trung-cua-nguoi-hmong/",
          urlToImage: "https://vfs.vn/wp-content/uploads/2021/03/hoi-gau-tao-su-kien-van-hoa-dac-trung-cua-nguoi-hmong-5-768x513.jpg",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "Bản sắc văn hóa từ nhạc cụ truyền thống của đồng bào Mông Tây Bắc",
          description: "Nhạc cụ truyền thống của người Mông Tây Bắc bao gồm khèn, kèn, trống, chiêng, sáo, cây gậy tiền (múa sênh tiền), đàn nhị, khèn môi, kèn lá. Các nhạc cụ được chế tác tại chỗ, từ bàn tay khéo léo, sự sáng tạo của chính những người sử dụng.",
          url: "https://www.qdnd.vn/van-hoa/doi-song/ban-sac-van-hoa-tu-nhac-cu-truyen-thong-cua-dong-bao-mong-tay-bac-682208",
          urlToImage: "https://file3.qdnd.vn/data/images/0/2022/01/01/thuthuytv/dongbaomong.jpg?dpi=150&quality=100&w=870",
          time: ""
      ));
      list.add(NewsDto(
          id: 0,
          title: "Nét độc đáo nhà ở trong kiến trúc người dân tộc Mông",
          description: "Nét độc đáo nhà ở trong kiến trúc người dân tộc Mông",
          url: "https://123docz.net/trich-doan/486308-nha-o-net-doc-dao-trong-kien-truc-cua-nguoi-hmong.htm",
          urlToImage: "https://cdn.daibieunhandan.vn/images/de2ce54bdb7a59a5f7ed9fad7e3b3f20963e83a227cde639033c8f27c39e60cb984d4668bbf1d3ee45021b574ea3ebcd/1651829418060.jpg",
          time: ""
      ));
      emit(state.copyWith(loadDataStatus: LoadStatus.success, listData: list));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
