import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/hmong_translation/view/quiz/quiz_page.dart';
import 'package:untitled/hmong_translation/view/translate/translate_page.dart';

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
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({Key? key}) : super(key: key);

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
           backgroundColor: Color(0xFFdae2f9),
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
                 icon: Icon(Icons.library_books), label: "Tài liệu"),
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
        return SizedBox();
      case 3:
        return SizedBox();
      default:
        return SizedBox();
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
