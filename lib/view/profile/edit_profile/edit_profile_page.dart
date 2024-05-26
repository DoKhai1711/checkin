import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/widget/loading_dialog.dart';
import 'package:untitled/widget/primary_button.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'edit_profile_cubit.dart';

class EditProfileArguments {
  EditProfileArguments();
}

class EditProfilePage extends StatelessWidget {
  final EditProfileArguments arguments;

  const EditProfilePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EditProfileCubit();
      },
      child: const EditProfileChildPage(),
    );
  }
}

class EditProfileChildPage extends StatefulWidget {
  const EditProfileChildPage({Key? key}) : super(key: key);

  @override
  State<EditProfileChildPage> createState() => _EditProfileChildPageState();
}

class _EditProfileChildPageState extends State<EditProfileChildPage> {
  late final EditProfileCubit _cubit;

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
          "Chỉnh sửa thông tin",
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
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listenWhen: (previous, current) =>
          previous.saveStatus != current.saveStatus,
      listener: (context, state) {
        if (state.saveStatus == LoadStatus.loading) {
          LoadingDialogTransparent.show(context);
        } else if (state.saveStatus == LoadStatus.success) {
          LoadingDialogTransparent.hide(context);
          showToast(
              message: "Lưu thông tin thành công",
            color: Colors.green,
          );
          Navigator.of(context).pop();
        } else if (state.saveStatus == LoadStatus.failure) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: "Lưu thông tin thất bại",
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<EditProfileCubit, EditProfileState>(
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetCustom.itemInfo(
                      title: "Tên đăng nhập",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        enabled: false,
                        initialValue: state.username,
                        onChange: (value) {},
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Mật khẩu",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Mật Khẩu',
                        initialValue: state.profile![Constant.PASS],
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
                      title: "Số điện thoại",
                      hasIcon: false,
                      widget: WidgetCustom.textField(
                        hintText: 'Số điện thoại',
                        initialValue: state.profile![Constant.PHONE],
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
                        initialValue: state.profile![Constant.ADDRESS],
                        onChange: (value) {
                          _cubit.onChangeData(
                            addressInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PrimaryButton(
                        title: 'Lưu',
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
