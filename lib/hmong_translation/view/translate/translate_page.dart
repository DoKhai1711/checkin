import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/app_theme.dart';

import 'translate_cubit.dart';

class TranslateArguments {

  TranslateArguments();
}

class TranslatePage extends StatelessWidget {
  final TranslateArguments arguments;

  const TranslatePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TranslateCubit();
      },
      child: const TranslateChildPage(),
    );
  }
}

class TranslateChildPage extends StatefulWidget {
  const TranslateChildPage({Key? key}) : super(key: key);

  @override
  State<TranslateChildPage> createState() => _TranslateChildPageState();
}

class _TranslateChildPageState extends State<TranslateChildPage> {
  late final TranslateCubit _cubit;
  final TextEditingController fromTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateCubit, TranslateState>(
        buildWhen: (previous, current) =>
            previous.loadDataStatus != current.loadDataStatus ||
            previous.changeData != current.changeData,
        builder: (context, state) {
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
                        Color(0xFF567798),
                      ],
                    ),
                  ),
                  child: SizedBox()),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        'assets/img/img_translation.png',
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          _cubit.changeTypeTranslate();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                state.isHmongToViet ? "Hmong" : "Tiếng việt",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.swap_horiz_outlined),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                state.isHmongToViet ? "Tiếng việt" : "Hmong",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: fromTextController,
                        minLines: 4,
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
                          hintText: "Nhập",
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
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _cubit.onTranslate(
                            text: fromTextController.text.trim()
                          );
                        },
                        child: const Text('Dịch'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: TextEditingController(text: state.toText),
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
                    ],
                  ),
                ),
              ),
            ],
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
