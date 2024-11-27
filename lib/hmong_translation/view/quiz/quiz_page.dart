import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';

import 'quiz_cubit.dart';

class QuizArguments {

  QuizArguments();
}

class QuizPage extends StatelessWidget {
  final QuizArguments arguments;

  const QuizPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return QuizCubit();
      },
      child: const QuizChildPage(),
    );
  }
}

class QuizChildPage extends StatefulWidget {
  const QuizChildPage({Key? key}) : super(key: key);

  @override
  State<QuizChildPage> createState() => _QuizChildPageState();
}

class _QuizChildPageState extends State<QuizChildPage> {
  late final QuizCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
     return Stack(
       children: [
         Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             decoration: const BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topRight,
                 end: Alignment.bottomLeft,
                 colors: [
                   Color(0xFFbdc3c7),
                   Color(0xFF2c3e50),
                 ],
               ),
             ),
             child: SizedBox()
         ),
         BlocBuilder<QuizCubit, QuizState>(
            buildWhen: (previous, current) =>
                previous.loadDataStatus != current.loadDataStatus,
            builder: (context, state) {
              if (state.loadDataStatus == LoadStatus.loading) {
                return LoadingIndicator();
              } else if (state.loadDataStatus == LoadStatus.failure) {
                return const Column(
                  children: [
                    SizedBox(),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int i = 0; i < (state.data ?? []).length; i++)...[
                          Center(
                            child: InkWell(
                              onTap: () {

                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 12),
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                child: Text(
                                  "${i+1}. ${state.data![i].title ?? ""}",
                                ),
                              ),
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                );
              }
            },
         ),
       ],
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
