import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';

import 'question_cubit.dart';

class QuestionArguments {
  int id;
  int type;

  QuestionArguments({
    required this.id,
    required this.type,
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
  TextEditingController answerController = TextEditingController();

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
    return BlocBuilder<QuestionCubit, QuestionState>(
      buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus ||
          previous.changeData != current.changeData,
      builder: (context, state) {
        if (state.loadDataStatus == LoadStatus.loading) {
          return Scaffold(
            body: LoadingIndicator(),
          );
        } else if (state.loadDataStatus == LoadStatus.success) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purpleAccent,
              title: Text(
                "Câu hỏi số ${state.index + 1}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 1,
              shadowColor: Colors.white,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.purpleAccent,
            ),
            body: Stack(
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
                    child: SizedBox()),
                if (state.index<(state.data?.list??[]).length)...[
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.arguments.type==2)...[
                            Image.memory(base64Decode(state.data?.list?[state.index]?.questionImg ?? "")),
                          ] else...[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: TextEditingController(text: state.data?.list?[state.index]?.questiontext ?? ""),
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
                            ),
                          ],
                          SizedBox(height: 20),
                          Text(
                            "Đáp án",
                            style: TextStyle(
                              color: AppTheme.appBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(height: 20),
                          if (widget.arguments.type==1)...[
                            fillInTheBlankWidget(),
                          ] else...[
                            selectAnswerWidget(),
                          ]
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      "Bạn đã trả lời hết tất cả câu hỏi",
                      style: TextStyle(
                        color: AppTheme.green_1,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
                Visibility(
                  visible: state.hasAnswered,
                  child: Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            answerController.text = "";
                            _cubit.nextQuest();
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Center(
                              child: Text(
                                "Câu hỏi tiếp theo",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state.loadDataStatus == LoadStatus.failure) {
          return Scaffold(
            body: Column(
              children: [
                Text(state.message ?? ""),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: LoadingIndicator(),
          );
        }
      },
    );
  }

  Widget selectAnswerWidget() {
    return Column(
      children: [
        for (int i = 0;
        i < (_cubit.state.data?.list?[_cubit.state.index]?.list ?? []).length;
        i++) ...[
          Center(
            child: InkWell(
              onTap: () {
                if (!_cubit.state.hasAnswered) {
                  _cubit.onAnswer(
                    answerIndex: i,
                  );
                }
              },
              child: Container(
                margin:
                const EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: _colorAnswer(
                      isCorrect: _cubit.state.data!.list![_cubit.state.index]!.list![i]?.iscorrect??0,
                      answerIndex: i,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    )
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 12),
                child: Center(
                  child: Text(
                    _cubit.state.data!.list![_cubit.state.index]!.list![i]
                        ?.answertext ??
                        "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ],
    );
  }

  Widget fillInTheBlankWidget() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: answerController,
              maxLines: null,
              cursorColor: AppTheme.blackText.withOpacity(0.5),
              style: AppTheme.blackS18W400,
              decoration: InputDecoration(
                fillColor: _colorFillInTheBlank(),
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
        ),
        SizedBox(height: 40),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: InkWell(
              onTap: () {
                _cubit.onAnswer(answerIndex: 0);
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    "Trả lời",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        Visibility(
          visible: _cubit.state.hasAnswered,
          child: Text(
              "Kết quả đúng: ${_cubit.state.data!.list![_cubit.state.index]!.list![0]?.answertext}",
            style: TextStyle(
              color: Colors.green,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Color _colorAnswer({
    required int isCorrect,
    required int answerIndex,
  }) {
    if (!_cubit.state.hasAnswered) {
      return Colors.white;
    } else {
      if (isCorrect == 1) {
        return Colors.green;
      } else {
        if (answerIndex == _cubit.state.answerIndex) {
          return Colors.red;
        } else {
          return Colors.white;
        }
      }
    }
  }

  Color _colorFillInTheBlank() {
    if (!_cubit.state.hasAnswered) {
      return Colors.white;
    } else {
      if (answerController.text == _cubit.state.data!.list![_cubit.state.index]!.list![0]?.answertext) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
