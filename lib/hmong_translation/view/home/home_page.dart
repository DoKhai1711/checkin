import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/hmong_translation/model/login/login_dto.dart';
import 'package:untitled/hmong_translation/view/culture/culture_page.dart';
import 'package:untitled/hmong_translation/view/login/login_page.dart';
import 'package:untitled/hmong_translation/view/news/news_page.dart';
import 'package:untitled/hmong_translation/view/quiz/quiz_page.dart';
import 'package:untitled/hmong_translation/view/translate/translate_page.dart';

import 'home_cubit.dart';

class HomeArguments {
  final LoginDto loginDto;

  HomeArguments({
    required this.loginDto,
  });
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
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(),
      bottomNavigationBar: NavigationBar(
          backgroundColor: const Color(0xFFdae2f9),
          height: 80,
          elevation: 0,
          selectedIndex: pageIndex,
          onDestinationSelected: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.translate), label: "Dịch"),
            NavigationDestination(
                icon: Icon(Icons.menu_book_outlined), label: "Bài tập"),
            NavigationDestination(
                icon: Icon(Icons.library_books), label: "Ngữ pháp"),
            NavigationDestination(
                icon: Icon(Icons.temple_buddhist_outlined), label: "Văn hoá"),
            NavigationDestination(icon: Icon(Icons.person), label: "Tài khoản"),
          ]),
    );
  }

  Widget _buildBodyWidget() {
    switch (pageIndex) {
      case 0:
        return TranslatePage(arguments: TranslateArguments());
      case 1:
        return QuizPage(arguments: QuizArguments());
      case 2:
        return NewsPage(arguments: NewsArguments());
      case 3:
        return CulturePage(arguments: CultureArguments());
      case 4:
        return profileWidget();
      default:
        return SizedBox();
    }
  }

  Widget profileWidget() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.shareicon.net/data/128x128/2016/05/24/770117_people_512x512.png'),
              ),
              SizedBox(height: 20),
              Text(
                widget.arguments.loginDto.username ?? "",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Email: ${widget.arguments.loginDto.email}'),
              SizedBox(height: 20),
              Text(
                "Quét QR để tham gia cộng đồng",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Image.asset(
                  "assets/img/qr_code.jpg",
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginPage(
                          arguments: LoginArguments(),
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                      child: Text(
                        "Đăng xuất",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
