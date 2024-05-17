import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/view/home/home_page.dart';

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
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.green.shade900,
                    Colors.green.shade500,
                    Colors.green.shade400,
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  // #login, #welcome
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Hệ thống tri ân du khách",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              // #email, #password
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(171, 171, 171, .7),
                                        blurRadius: 20,
                                        offset: Offset(0, 10)),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200)),
                                      ),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Tên đăng nhập",
                                          hintStyle:
                                          TextStyle(color: Colors.grey),
                                          border: InputBorder.none,),
                                        onChanged: (value) {
                                          _cubit.inputAcc(
                                            username: value,
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200)),
                                      ),
                                      child: TextField(
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            hintText: "Mật khẩu",
                                            hintStyle:
                                            TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        onChanged: (value) {
                                          _cubit.inputAcc(
                                            password: value,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              // #login
                              InkWell(
                                onTap: () {
                                  String validate = _cubit.check();
                                  if (validate.isEmpty) {
                                    showToast(
                                      message: "Đăng nhập thành công",
                                      color: Colors.green
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HomePage(
                                          arguments: HomeArguments(),
                                        ),
                                      ),
                                    );
                                  } else {
                                    showToast(
                                        message: validate,
                                        color: Colors.red
                                    );
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green[800]),
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Design by TruTien171",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
