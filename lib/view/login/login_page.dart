import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/view/create_account/create_account_page.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'login_cubit.dart';

class LoginArguments {
  LoginArguments();
}

class LoginPage extends StatelessWidget {
  final LoginArguments arguments;

  const LoginPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: LoginChildPage(
        arguments: arguments,
      ),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  final LoginArguments arguments;

  const LoginChildPage({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  late final LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            previous.loadDataStatus != current.loadDataStatus,
        builder: (context, state) {
          if (state.loadDataStatus == LoadStatus.loading ||
              state.loadDataStatus == LoadStatus.initial) {
            return LoadingIndicator();
          } else if (state.loadDataStatus == LoadStatus.failure) {
            return Column(
              children: [
                Expanded(
                  child: EmptyListWidget(
                    onRefresh: () async {},
                  ),
                ),
              ],
            );
          } else {
            return Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    "assets/img/bg_sapa.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 1 / 10),
                      Center(
                        child: Image.asset(
                          "assets/img/Paft.png",
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          height: MediaQuery.of(context).size.width * 1 / 2,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 350,
                          decoration: BoxDecoration(
                            color: AppTheme.green_1,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 40, bottom: 20),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppTheme.green_2,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextFormField(
                                    cursorColor:
                                    AppTheme.blackText.withOpacity(0.5),
                                    style: TextStyle(color: Colors.green.shade700),
                                    inputFormatters: Utils.getInputFormatters(
                                      maxLength: 255,
                                      inputFormatters: null,
                                    ),
                                    onChanged: (value) {
                                      _cubit.inputAcc(
                                        username: value,
                                      );
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                        10.0,
                                        10.0,
                                        20.0,
                                        10.0,
                                      ),
                                      labelText: 'Tên đăng nhập',
                                      labelStyle: TextStyle(color: Colors.white),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0, bottom: 20),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppTheme.green_2,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextFormField(
                                    cursorColor:
                                        AppTheme.blackText.withOpacity(0.5),
                                    style: TextStyle(color: Colors.green.shade700),
                                    inputFormatters: Utils.getInputFormatters(
                                      maxLength: 255,
                                      inputFormatters: null,
                                    ),
                                    onChanged: (value) {
                                      _cubit.inputAcc(
                                        password: value,
                                      );
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                        10.0,
                                        10.0,
                                        20.0,
                                        10.0,
                                      ),
                                      labelText: 'Mật khẩu',
                                      labelStyle: TextStyle(color: Colors.white),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    showToast(
                                      message:
                                          "Tính năng đang trong giai đoạn phát triển",
                                      color: Colors.red,
                                    );
                                  },
                                  child: Text(
                                    'Quên mật khẩu',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CreateAccountPage(
                                          arguments: CreateAccountArguments(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Tạo tài khoản mới',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () async {
                                  String validate = await _cubit.check();
                                  if (validate.isEmpty) {
                                    showToast(
                                        message: "Đăng nhập thành công",
                                        color: Colors.green);
                                    _cubit.changePage(context);
                                  } else {
                                    showToast(
                                        message: validate, color: Colors.red);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green[800]),
                                  child: const Center(
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
