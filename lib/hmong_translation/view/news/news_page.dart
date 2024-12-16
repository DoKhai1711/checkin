import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/hmong_translation/view/news/widgets/article_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'news_cubit.dart';

class NewsArguments {

  NewsArguments();
}

class NewsPage extends StatelessWidget {
  final NewsArguments arguments;

  const NewsPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NewsCubit();
      },
      child: const NewsChildPage(),
    );
  }
}

class NewsChildPage extends StatefulWidget {
  const NewsChildPage({Key? key}) : super(key: key);

  @override
  State<NewsChildPage> createState() => _NewsChildPageState();
}

class _NewsChildPageState extends State<NewsChildPage>
    with SingleTickerProviderStateMixin {
  late final NewsCubit _cubit;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _tabController = TabController(length: 2, vsync: this);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      buildWhen: (previous, current) =>
      previous.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        if (state.loadDataStatus == LoadStatus.loading) {
          return Scaffold(
            body: LoadingIndicator(),
          );
        } else if (state.loadDataStatus == LoadStatus.failure) {
          return Scaffold(
            body: Column(
              children: [SizedBox()],
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Tài liệu'),
                      Tab(text: 'Video'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _documentWidget(),
                        _videoWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _documentWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/img/doc_1.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_2.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_3.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_4.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_5.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_6.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_7.png",
            ),
          ), Center(
            child: Image.asset(
              "assets/img/doc_8.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_9.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_10.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_11.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_12.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/img/doc_13.png",
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoWidget() {
    return ListView.builder(
      itemCount: (_cubit.state.listData??[]).length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: _cubit.state.listData![index],
          isRemovable: true,
          onArticlePressed: (data) async {
            if (!await launchUrl(Uri.parse(data.url??""))) {
              throw Exception('Could not launch');
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
