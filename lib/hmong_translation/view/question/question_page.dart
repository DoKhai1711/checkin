import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';

import 'question_cubit.dart';

class QuestionArguments {
  int id;

  QuestionArguments({
    required this.id,
  });
}

class QuestionPage extends StatelessWidget {
  final QuestionArguments arguments;

  const QuestionPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return QuestionCubit();
      },
      child: QuestionChildPage(
        arguments: arguments,
      ),
    );
  }
}

class QuestionChildPage extends StatefulWidget {
  final QuestionArguments arguments;
  const QuestionChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<QuestionChildPage> createState() => _QuestionChildPageState();
}

class _QuestionChildPageState extends State<QuestionChildPage> {
  late final QuestionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(
      id: widget.arguments.id,
    );
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
        BlocBuilder<QuestionCubit, QuestionState>(
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
                      Center(
                        child: TextFormField(
                          initialValue: state.data?.list?[state.index]?.questiontext ?? "",
                          minLines: 4,
                          readOnly: true,
                          maxLines: null,
                          cursorColor: AppTheme.blackText.withOpacity(0.5),
                          style: AppTheme.blackS18W400,
                          decoration: const InputDecoration(
                            fillColor: AppTheme.white,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(
                              10.0,
                              10.0,
                              20.0,
                              10.0,
                            ),
                            hintStyle: AppTheme.greyHintS16W400,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide(
                                color: AppTheme.greyText,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide(
                                color: AppTheme.greyText,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide(
                                color: AppTheme.greyText,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      for(int i = 0; i < (state.data?.list ?? []).length; i++)...[
                        Center(
                          child: InkWell(

                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              child: Text(
                                "${i+1}. ${state.data!.list![state.index]!.list![i]?.answertext ?? ""}",
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


  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
