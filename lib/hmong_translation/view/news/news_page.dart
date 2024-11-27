import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/hmong_translation/view/news/widgets/article_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _NewsChildPageState extends State<NewsChildPage> {
  late final NewsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
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
          return ListView.builder(
            itemCount: (state.listData??[]).length,
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.listData![index],
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
      },
    );
  }

  Widget _buildBodyWidget() {
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
