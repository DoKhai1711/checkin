import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'home_cubit.dart';

class HomeArguments {
  HomeArguments();
}

class HomePage extends StatelessWidget {
  final HomeArguments arguments;

  const HomePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit();
      },
      child: HomeChildPage(
        arguments: arguments,
      ),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  final HomeArguments arguments;

  const HomeChildPage({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final HomeCubit _cubit;

  int bottomBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Mã QR của tôi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.green.shade500,
      ),
      body: _buildBodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        currentIndex: bottomBarIndex,
        onTap: (int index) async {
          setState(() {
            bottomBarIndex = index;
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
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          )
        ],
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          WidgetCustom.cardCustom(
            widget: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: QrImageView(
                  data: '0859727969',
                  version: QrVersions.auto,
                  size: MediaQuery.of(context).size.width * 6 / 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
