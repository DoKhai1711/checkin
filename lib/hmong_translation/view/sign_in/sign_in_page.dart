import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/widget/loading_dialog.dart';
import 'package:untitled/widget/primary_button.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'sign_in_cubit.dart';

class SignInArguments {

  SignInArguments();
}

class SignInPage extends StatelessWidget {
  final SignInArguments arguments;

  const SignInPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignInCubit();
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({Key? key}) : super(key: key);

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late final SignInCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Đăng ký",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.purple,
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (previous, current) =>
      previous.saveStatus != current.saveStatus,
      listener: (context, state) {
        if (state.saveStatus == LoadStatus.loading) {
          LoadingDialogTransparent.show(context);
        } else if (state.saveStatus == LoadStatus.success) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: "Tạo tài khoản thành công",
            color: Colors.green,
          );
          Navigator.of(context).pop();
        } else if (state.saveStatus == LoadStatus.failure) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: "Tạo tài khoản thất bại",
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<SignInCubit, SignInState>(
          buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus ||
              previous.changeData != current.changeData,
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetCustom.itemInfo(
                      title: "Họ và tên",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        initialValue: state.username,
                        hintText: "Họ và tên",
                        onChange: (value) {
                          _cubit.onChangeData(
                            usernameInput: value.trim(),
                          );
                        },
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Email",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        initialValue: state.email,
                        hintText: "Email",
                        onChange: (value) {
                          _cubit.onChangeData(
                            emailInput: value.trim(),
                          );
                        },
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Mật khẩu",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Mật Khẩu',
                        obscureText: true,
                        onChange: (value) {
                          _cubit.onChangeData(
                            passwordInput: value.trim(),
                          );
                        },
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Nhập lại mật khẩu",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Mật Khẩu',
                        obscureText: true,
                        onChange: (value) {
                          _cubit.onChangeData(
                            passwordAgainInput: value.trim(),
                          );
                        },
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PrimaryButton(
                        title: 'Đăng ký',
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 16,
                        ),
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(38),
                        onTap: () {
                          String error = _cubit.validate();
                          if (error.isEmpty) {
                            _cubit.onSave();
                          } else {
                            showToast(
                              message: error,
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
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
