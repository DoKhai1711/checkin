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

import 'pay_cubit.dart';

class PayArguments {
  String code;

  PayArguments({
    required this.code,
  });
}

class PayPage extends StatelessWidget {
  final PayArguments arguments;

  const PayPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  static Route route({
    required PayArguments arguments,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => PayPage(
        arguments: arguments,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PayCubit();
      },
      child: PayChildPage(
        arguments: arguments,
      ),
    );
  }
}

class PayChildPage extends StatefulWidget {
  final PayArguments arguments;

  const PayChildPage({
    required this.arguments,
    Key? key
  }) : super(key: key);

  @override
  State<PayChildPage> createState() => _PayChildPageState();
}

class _PayChildPageState extends State<PayChildPage> {
  late final PayCubit _cubit;

  List<String> list = <String>[
    '<2 hành khách',
    '2 - 5 hành khách',
    '5 - 10 hành khách',
    '10 - 20 hành khách',
    '>20 hành khách',
  ];

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    dropdownValue = list.first;
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Tri ân tài xế",
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
    return BlocConsumer<PayCubit, PayState>(
      listenWhen: (previous, current) =>
          previous.saveStatus != current.saveStatus,
      listener: (context, state) {
        if (state.saveStatus == LoadStatus.loading) {
          LoadingDialogTransparent.show(context);
        } else if (state.saveStatus == LoadStatus.success) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: "Tri ân thành công",
            color: Colors.green,
          );
          Navigator.of(context).pop();
        } else if (state.saveStatus == LoadStatus.failure) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: "Tri ân thất bại",
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<PayCubit, PayState>(
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
                      widget: WidgetCustom.textView(
                          text: state.listAccount![widget.arguments.code][Constant.NAME]
                      ),
                    ),
                    WidgetCustom.itemInfo(
                      title: "Số điện thoại",
                      widget: WidgetCustom.textView(
                          text: state.listAccount![widget.arguments.code][Constant.PHONE]
                      ),
                    ),
                    WidgetCustom.itemInfo(
                      title: "Địa chỉ",
                      widget: WidgetCustom.textView(
                          text: state.listAccount![widget.arguments.code][Constant.ADDRESS]
                      ),
                    ),
                    WidgetCustom.itemInfo(
                      title: "Số lượng khách hàng",
                      widget: DropdownMenu<String>(
                        initialSelection: list.first,
                        width: MediaQuery.of(context).size.width-20,
                        onSelected: (String? value) {
                          _cubit.setScore(
                            value: value!,
                            list: list,
                          );
                        },
                        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    WidgetCustom.itemInfo(
                      title: "Tiền tri ân",
                      widget: WidgetCustom.textField(
                        hintText: 'Tiền tri ân',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(Constant.TYPE_REGEXP_PHONE_NUMBER),
                          ),
                        ],
                        maxLength: 10,
                        onChange: (value) {
                          _cubit.onChangeData(
                            moneyInput: value.trim(),
                          );
                        },
                      ),
                      isRequired: true,
                      isShowDivider: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PrimaryButton(
                        title: 'Thanh toán',
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 16,
                        ),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(38),
                        onTap: () {
                          String error = _cubit.validate();
                          if (error.isEmpty) {
                            _cubit.onSave(
                              customer: widget.arguments.code,
                            );
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
