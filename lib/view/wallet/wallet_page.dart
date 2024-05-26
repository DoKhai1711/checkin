import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/show_message.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widget/loading_dialog.dart';

import 'wallet_cubit.dart';

class WalletArguments {
  WalletArguments();
}

class WalletPage extends StatelessWidget {
  final WalletArguments arguments;

  const WalletPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WalletCubit();
      },
      child: const WalletChildPage(),
    );
  }
}

class WalletChildPage extends StatefulWidget {
  const WalletChildPage({Key? key}) : super(key: key);

  @override
  State<WalletChildPage> createState() => _WalletChildPageState();
}

class _WalletChildPageState extends State<WalletChildPage> {
  late final WalletCubit _cubit;

  TextEditingController _stkController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return BlocConsumer<WalletCubit, WalletState>(
      listenWhen: (previous, current) =>
          previous.saveStatus != current.saveStatus,
      listener: (context, state) {
        if (state.saveStatus == LoadStatus.loading) {
          LoadingDialogTransparent.show(context);
        } else if (state.saveStatus == LoadStatus.success) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: state.type == Constant.RECHARGE
                ? 'Nạp tiền thành công'
                : 'Rút tiền thành công',
            color: Colors.green,
          );
        } else if (state.saveStatus == LoadStatus.failure) {
          LoadingDialogTransparent.hide(context);
          showToast(
            message: state.type == Constant.RECHARGE
                ? 'Nạp tiền thất bại'
                : 'Rút tiền thất bại',
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<WalletCubit, WalletState>(
          buildWhen: (previous, current) =>
              previous.loadDataStatus != current.loadDataStatus ||
              previous.type != current.type ||
              previous.saveStatus != current.saveStatus,
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
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                            "assets/img/Paft.png",
                            width: 90,
                            height: 90,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Ví điện tử",
                          style: TextStyle(
                              color: Colors.green.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 33),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.green_2,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.green_3,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 4,
                                    bottom: 8,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Số dư khả dụng',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 8,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${state.profile!['money']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.green_text,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              _cubit.setRechargeType();
                            },
                            child: Container(
                              height: 170,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppTheme.green_2,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 8,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Nạp tiền',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.green_text,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.upload,
                                    size: 80,
                                    color: AppTheme.green_text,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              _cubit.setWithDrawType();
                            },
                            child: Container(
                              height: 170,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppTheme.green_2,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 8,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Rút tiền',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.green_text,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.file_download,
                                    size: 80,
                                    color: AppTheme.green_text,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (state.type != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 40, bottom: 20),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.green_2,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: _stkController,
                            cursorColor: AppTheme.blackText.withOpacity(0.5),
                            style: TextStyle(color: Colors.green.shade700),
                            keyboardType: TextInputType.number,
                            inputFormatters: Utils.getInputFormatters(
                              maxLength: 255,
                              inputFormatters: null,
                            ),
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                10.0,
                                10.0,
                                20.0,
                                10.0,
                              ),
                              hintText: 'Số tài khoản',
                              hintStyle: TextStyle(color: Colors.white),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: _nameController,
                            cursorColor: AppTheme.blackText.withOpacity(0.5),
                            style: TextStyle(color: Colors.green.shade700),
                            keyboardType: TextInputType.name,
                            inputFormatters: Utils.getInputFormatters(
                              maxLength: 255,
                              inputFormatters: null,
                            ),
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                10.0,
                                10.0,
                                20.0,
                                10.0,
                              ),
                              hintText: 'Chủ tài khoản',
                              hintStyle: TextStyle(color: Colors.white),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: _moneyController,
                            cursorColor: AppTheme.blackText.withOpacity(0.5),
                            style: TextStyle(color: Colors.green.shade700),
                            keyboardType: TextInputType.number,
                            inputFormatters: Utils.getInputFormatters(
                              maxLength: 255,
                              inputFormatters: null,
                            ),
                            onChanged: (value) {

                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                10.0,
                                10.0,
                                20.0,
                                10.0,
                              ),
                              hintText: state.type == Constant.RECHARGE
                                  ? 'Số tiền muốn nạp'
                                  : 'Số tiền muốn rút',
                              hintStyle: const TextStyle(color: Colors.white),
                              errorBorder: const OutlineInputBorder(
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
                      const SizedBox(height: 30),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          _cubit.changeMoney(
                            name: _nameController.text.trim(),
                            stk: _stkController.text.trim(),
                            money: _moneyController.text.trim(),
                          );
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[800]),
                          child: Center(
                            child: Text(
                              state.type == Constant.RECHARGE
                                  ? 'Nạp tiền'
                                  : 'Rút tiền',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
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
    _moneyController.dispose();
    _stkController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
