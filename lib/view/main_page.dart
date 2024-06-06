import 'package:flutter/material.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/view/detail_statistical/detail_statistical_page.dart';
import 'package:untitled/view/home/home_page.dart';
import 'package:untitled/view/home_web/home_web_page.dart';
import 'package:untitled/view/pay/pay_page.dart';
import 'package:untitled/view/profile/setting_page.dart';
import 'package:untitled/view/statistical/statistical_page.dart';
import 'package:untitled/view/statistical_employee/statistical_employee_page.dart';
import 'package:untitled/view/wallet/wallet_page.dart';
import 'package:untitled/widget/scan_qr.dart';

class MainPage extends StatefulWidget {
  String type;

  MainPage({
    required this.type,
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyEmployeeWidget(indexPage),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        currentIndex: indexPage,
        onTap: (int index) async {
          setState(() {
            indexPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'Thống kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Cài đặt',
          )
        ],
      ),
    );
  }
}

Widget _bodyCustomerWidget(int index) {
  if (index == 0) {
    return HomePage(arguments: HomeArguments());
  } else if (index == 1) {
    return StatisticalPage(arguments: StatisticalArguments());
    // return PayPage(
    //   arguments: PayArguments(
    //       code: 'thien'
    //   ),
    // );
  }
  if (index == 2) {
    return WalletPage(arguments: WalletArguments());
  } else {
    return const SettingPage();
  }
}

Widget _bodyEmployeeWidget(int index) {
  if (index == 0) {
    return HomeWebPage(
      arguments: HomeWebArguments(),
    );
  } else if (index == 1) {
    return StatisticalEmployeePage(arguments: StatisticalEmployeeArguments());
  } else {
    return const SettingPage();
  }
}
