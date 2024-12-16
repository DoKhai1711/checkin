import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/hmong_translation/view/news/widgets/article_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'culture_cubit.dart';

class CultureArguments {

  CultureArguments();
}

class CulturePage extends StatelessWidget {
  final CultureArguments arguments;

  const CulturePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CultureCubit();
      },
      child: const CultureChildPage(),
    );
  }
}

class CultureChildPage extends StatefulWidget {
  const CultureChildPage({Key? key}) : super(key: key);

  @override
  State<CultureChildPage> createState() => _CultureChildPageState();
}

class _CultureChildPageState extends State<CultureChildPage> {
  late final CultureCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: ListView.builder(
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
         ),
       ),
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
