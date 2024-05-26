import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /*
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color notBlack = Color(0xFF000000);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);
  static const Color nearlyGreen =  Color(0xFF0ABB76);
  static const Color nearlyBlue =  Color(0xFF14548C);
  static const Color headerIcons =  Color(0xFF049DBF);
  static const Color controlActiveIcons =  Color(0xFF009688);
  static const Color controlDeActiveIcons =  Color(0xFFC6C5C5);
  static const Color menuItem =  Color(0xFF14548C);
  static const Color tabTitleColor =  Color(0xFF049DBF);
  static const Color timeColor =  Color(0xFF7F7F7F);
  */

  static const Color appRed = Color(0xFFEC324E);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color nearlyGreen = Color(0xFF0ABB76);
  static const Color nearlyYellow = Color(0xFFFEB139);
  static const Color buttonSecond = Color(0xFFF2F3F2);
  static const Color titleNotify = Color(0xff24264E);
  static const Color btn_login = Color(0xffA0D2FF);
  static const Color title_item_setting = Color(0xff121212);
  static const Color item_information = Color(0xff757575);
  static const Color bg_information = Color(0xfffafafa);
  static const Color title_text = Color(0xff141ED2);
  static const Color border_top_sheet = Color(0xffffdfdfdf);

  static const Color white = Colors.white;
  static const Color orange = Colors.deepOrange;
  static const Color blue = Colors.blue;
  static const Color purple = Colors.purple;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color grey = Colors.grey;
  static const Color appBlue = Color(0xFF151FD2);
  static const Color appGrey = Color(0xFFF5F5F5);
  static const Color appLightGrey = Color(0xFFedeaea);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF7C7C7C);
  static const Color labelText = Color(0xFF151FD2);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color bgGrey = Color(0xFFF2F1F6);
  static const Color bgDisabledTuNgay = Color(0xFFb1b1b1);
  static const Color boderDisabledTuNgay = Color(0xFFd7d7d7);

  //static const Color dismissibleBackground = Color(0xFF364A54);
  //static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Raleway';
  static const Color bgrTextField = Color(0xFFFF7F7F7);
  static const Color borderTextField = Color(0xFFC0C0C0);
  static const Color selectedCheckbox = Color(0xFFe6eaee);
  static const Color viewItem = Color(0xFF0e97d6);

  static const Color homeTitleIcon = Color(0xFF818197);
  static const Color homeListTitle = Color(0xFF273240);
  static const Color btnMoiTao = Color(0xFF818197);
  static const Color btnDangTrinhKy = Color(0xFFFF8700);
  static const Color btnDaPheDuyet = Color(0xFF22B07D);
  static const Color btnDaBanHanh = Color(0xFF22B07D);
  static const Color btnDaHuy = appRed;
  static const Color subTitleDsLamThem = Color(0xFF2C3A4B);
  static const Color formTitleLamThem = Color(0xFF7E8C91);
  static const Color fileLamThem = Color(0xFF898EE8);
  static const Color tenNguoiKy = Color(0xFF141ED2);
  static const Color maNguoiKy = Color(0xFF141ED2);
  static const Color backGround = Color(0xFFF3F3F8);

  static const Color qrTenNV = Color(0xFF141ED2);
  static const Color qrAdBaoCao = Color(0xFF2C3A4B);

  static const blueText = Color(0xFF141ED2);
  static const greyIndicator = Color(0xFFE0E0E0);
  static const greyColorIncome = Color(0xFFB5B4B4);
  static const blackText = Color(0xFF121212);
  static const greyCircle = Color(0xFFBDBDBD);
  static const greyText = Color(0xFF616161);
  static const blueRadio = Color(0xFFA0D2FF);
  static const blueBgDateRanger = Color(0xFFEBF3FF);
  static const textDayName = Color(0xFF949499);
  static const bgNewFile = Color(0xFFFFFFFF);
  static const colorGreyButton = Color(0xFF617082);
  static const colorRejectButton = Color(0xFFEB2D4B);

  static const bottomNavigatorBar = Color(0xFF3C4D61);
  static const tabBarColor = Color(0xFF2356C5);
  static final borderIconImage = Color(0x11707070);

  static final borderTable = Color(0xFFB9B9B9);
  static final statusBar = Color(0xFFEEF5FF);

  static final green_1 = Color(0xFFe8f1ec);
  static final green_2 = Color(0xFFacccb7);
  static final green_3 = Color(0xFF61a477);
  static final green_text = Color(0xFF46825a);


  static const List<Color> backgroundAppbar = [
    Color(0xFF232F3F),
    Color(0xFF2C3B50),
    Color(0xFF314256),
    Color(0xFF3D4E62),
  ];

  static const List<Color> backgroundAppbar2 = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  static const List<Color> backgroundHome = [
    Color(0xffeef5ff),
    Color(0xffeef5ff),
    Colors.white,
  ];

  static const List<Color> backgroundSetting = [
    Color(0xffeef5ff),
    Color(0xffeef5ff),
    Color(0xffeef5ff),
    Colors.white,
  ];

  static const List<Color> colorBtnLogin = [
    Color(0xff458BFE),
    Color(0xff78C0FF),
  ];

  static const TextTheme textTheme = TextTheme(
    headline1: headline,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
    subtitle1: subtitle,
  );

  static const TextStyle blueS18W400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: blueText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle titleNotifyS18W400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: titleNotify,
  );

  static const TextStyle blueS18W500 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: blueRadio,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle blueS16W700 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: blueText,
  );

  static const TextStyle blueS18W500Italic = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: blueRadio,
    fontFamily: 'AvertaStdCY-Regular',
    fontStyle: FontStyle.italic,
  );

  static const TextStyle blackS18W700 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: blackText,
  );

  static const TextStyle blackS24W700 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: blackText,
    fontFamily: 'AvertaStdCY-Bold',
  );

  static const TextStyle blackS24W400 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: blackText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle greyS18W700 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: greyText,
  );

  static const TextStyle blackS18W400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: blackText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle blackS16W400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: blackText,
  );

  static const TextStyle blackS14W400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: blackText,
  );

  static const TextStyle blackS12W400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: blackText,
  );

  static const TextStyle blackS18W400Italic = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: blackText,
  );

  static const TextStyle greyS18W400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: greyText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle item_informationS14W400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: item_information,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle blueTextS14W400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: blueText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle blueTextS18W500 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: blueText,
  );

  static const TextStyle blueTextS18W400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: blueText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle greyS18W400Italic = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: greyText,
  );

  static const TextStyle greyHintS16W400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: greyIndicator,
  );

  static const TextStyle whiteS16W600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppTheme.white,
  );

  static const TextStyle whiteS14W600 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppTheme.white,
      fontFamily: 'AvertaStdCY-Semibold'
  );

  static const TextStyle whiteS16W600Italic = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppTheme.white,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle whiteS12W400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.white,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle labelTitle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: lightText, // was lightText
  );

  static const TextStyle labelValue = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: darkerText, // was lightText
  );

  static const TextStyle labelError = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.red, // was lightText
  );

  static const TextStyle featureTitle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppTheme.homeTitleIcon, // was lightText
  );

  static TextStyle homeTopControlsTitle = const TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppTheme.homeTitleIcon, // was lightText
  );

  static const TextStyle listTitleStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppTheme.homeListTitle, // was lightText
  );

  static const TextStyle dsLamThemTitleStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppTheme.black, // was lightText
  );

  static const TextStyle dsLamThemItemStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppTheme.black, // was lightText
  );

  static const TextStyle xemDsLamThemItemStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: AppTheme.black, // was lightText
  );

  static const TextStyle xemDsLamThemSubItemStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppTheme.formTitleLamThem, // was lightText
  );

  static const TextStyle tenNguoiKyStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppTheme.tenNguoiKy, // was lightText
  );

  static const TextStyle qrCodeTitleStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 21,
    color: AppTheme.tenNguoiKy, // was lightText
  );

  static const TextStyle maNguoiKyStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppTheme.maNguoiKy, // was lightText
  );

  static const TextStyle dsLamThemSubTitleStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 17,
    color: AppTheme.subTitleDsLamThem, // was lightText
  );

  static const TextStyle dsLamThemItemTrangThaiStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: AppTheme.white, // was lightText
  );

  static const TextStyle titleFormLamThemStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppTheme.formTitleLamThem, // was lightText
  );

  static const TextStyle textFormLamThemStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppTheme.formTitleLamThem, // was lightText
  );

  static const TextStyle fileFormLamThemStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppTheme.fileLamThem, // was lightText
  );

  static const TextStyle subListTitleStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppTheme.homeTitleIcon, // was lightText
  );

  static const TextStyle qrTenNvStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppTheme.qrTenNV, // was lightText
  );

  static const TextStyle qrSubTitleStyle = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 17,
    color: AppTheme.formTitleLamThem, // was lightText
  );

  static const TextStyle textFormSemiBoldSize18 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Semibold', // was lightText
  );

  static const TextStyle textFormBoldSize24 = TextStyle(
    // Caption -> caption
    fontSize: 24,
    color: Color(0xff141ED2),
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormBoldSize24_1 = TextStyle(
    // Caption -> caption
    fontSize: 24,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormBoldSize18 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: Colors.white,
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormBoldSize18_1 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: title_item_setting,
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormBoldSize18_2 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormBoldSize16 = TextStyle(
    // Caption -> caption
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormBoldSize14 = TextStyle(
    // Caption -> caption
    fontSize: 14,
    color: title_item_setting,
    fontFamily: 'AvertaStdCY-Bold', // was lightText
  );

  static const TextStyle textFormRegularSize24 = TextStyle(
    // Caption -> caption
    fontSize: 24,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize18 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize18_1 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: item_information,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize18_2 = TextStyle(
    // Caption -> caption
    fontSize: 18,
    color: title_text,
    fontFamily: 'AvertaStdCY-Regular',
    fontStyle: FontStyle.italic, // was lightText
  );

  static const TextStyle textFormRegularSize16 = TextStyle(
    // Caption -> caption
    fontSize: 16,
    color: Color(0xff141ED2),
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize16_1 = TextStyle(
    // Caption -> caption
    fontSize: 16,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize16_2 = TextStyle(
    // Caption -> caption
    fontSize: 16,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize16_3 = TextStyle(
    // Caption -> caption
    fontSize: 16,
    color: title_item_setting,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize16_4 = TextStyle(
    // Caption -> caption
    fontSize: 16,
    color: title_text,
    decoration: TextDecoration.underline,
    decorationColor: title_text,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize14 = TextStyle(
    // Caption -> caption
    fontSize: 14,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize14_1 = TextStyle(
    // Caption -> caption
    fontSize: 14,
    color: titleNotify,
    fontFamily: 'AvertaStdCY-Regular',
    decoration: TextDecoration.underline, // was lightText
  );

  static const TextStyle textFormRegularSize14_2 = TextStyle(
    // Caption -> caption
    fontSize: 14,
    color: btn_login,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize14_3 = TextStyle(
    // Caption -> caption
    fontSize: 14,
    color: Colors.white,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize13 = TextStyle(
    // Caption -> caption
    fontSize: 13,
    color: Color(0xff90A3BF),
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize12 = TextStyle(
    // Caption -> caption
    fontSize: 12,
    color: Colors.red,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize12_1 = TextStyle(
    // Caption -> caption
    fontSize: 12,
    color: title_item_setting,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle textFormRegularSize11 = TextStyle(
      // Caption -> caption
      fontSize: 11,
      color: title_text,
      fontFamily: 'AvertaStdCY-Regular',// was lightText
      );

  static const TextStyle textFormRegularSize11_1 = TextStyle(
      // Caption -> caption
      fontSize: 11,
      color: item_information,
      fontFamily: 'AvertaStdCY-Regular', // was lightText
      );

  static const TextStyle textFormRegularSize5 = TextStyle(
    // Caption -> caption
      fontSize: 5,
      color: Colors.white,
      fontFamily: 'AvertaStdCY-Regular',
  );

  static const TextStyle whiteS10W400 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: white,
  );

  static const TextStyle whiteS18W600 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: white,
  );

  static const TextStyle textHomeFormRegularSize14_2 = TextStyle(
    // Caption -> caption
    fontSize: 14,
    color: item_information,
    fontFamily: 'AvertaStdCY-Regular', // was lightText
  );

  static const TextStyle blueTextHomeS14W400 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: blueText,
    fontFamily: 'AvertaStdCY-Regular',
  );

  static BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: AppTheme.borderTextField),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)));
  }

  static ShapeDecoration borderRadius12White() {
    return ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ));
  }

  static BoxDecoration myHomeBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 1.0,
        color: Colors.grey.withOpacity(0.2),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 9,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static BoxDecoration imageHomeBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xffeef5ff),
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(255.0),
        bottomRight: Radius.circular(255.0),
      ),
    );
  }

  static BoxDecoration iconHomeBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 0,
          offset: const Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }

  static BoxDecoration numberNotify() {
    return const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle);
  }
}

ButtonStyle btnOption() {
  return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff617082),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
