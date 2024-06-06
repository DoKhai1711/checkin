import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/widget/loading_dialog.dart';
import 'package:untitled/widget/primary_button.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'create_account_cubit.dart';

class CreateAccountArguments {

  CreateAccountArguments();
}

class CreateAccountPage extends StatelessWidget {
  final CreateAccountArguments arguments;

  const CreateAccountPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CreateAccountCubit();
      },
      child: const CreateAccountChildPage(),
    );
  }
}

class CreateAccountChildPage extends StatefulWidget {
  const CreateAccountChildPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountChildPage> createState() => _CreateAccountChildPageState();
}

class _CreateAccountChildPageState extends State<CreateAccountChildPage> {
  late final CreateAccountCubit _cubit;

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
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Tạo tài khoản",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.black,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.green.shade500,
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return BlocConsumer<CreateAccountCubit, CreateAccountState>(
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
        return BlocBuilder<CreateAccountCubit, CreateAccountState>(
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
                      title: "Tên đăng nhập",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        initialValue: state.username,
                        hintText: "Tên đăng nhập",
                        onChange: (value) {
                          _cubit.onChangeData(
                            usernameInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Mật khẩu",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Mật Khẩu',
                        onChange: (value) {
                          _cubit.onChangeData(
                            passwordInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Tên nguời dùng",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        initialValue: state.username,
                        hintText: "Tên người dùng",
                        onChange: (value) {
                          _cubit.onChangeData(
                            nameInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Số điện thoại",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Số điện thoại',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(Constant.TYPE_REGEXP_PHONE_NUMBER),
                          ),
                        ],
                        maxLength: 10,
                        onChange: (value) {
                          _cubit.onChangeData(
                            phoneInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Địa chỉ",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Địa chỉ',
                        onChange: (value) {
                          _cubit.onChangeData(
                            addressInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Loại tài khoản",
                      hasIcon: false,
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text(
                              "Người dẫn đoàn",
                              style: AppTheme.blackS18W400,
                            ),
                            leading: Radio(
                              value: state.type == Constant.CUSTOMER,
                              groupValue: true,
                              onChanged: (value) {
                                _cubit.changeType(Constant.CUSTOMER);
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "Người kinh doanh",
                              style: AppTheme.blackS18W400,
                            ),
                            leading: Radio(
                              value: state.type == Constant.EMPLOYEE,
                              groupValue: true,
                              onChanged: (value) {
                                _cubit.changeType(Constant.EMPLOYEE);
                              },
                            ),
                          ),
                        ],
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PrimaryButton(
                        title: 'Tạo tài khoản',
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 16,
                        ),
                        color: Colors.green,
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
