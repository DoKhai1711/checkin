import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/view/detail_statistical/detail_statistical_page.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'home_cubit.dart';

class HomeArguments {
  HomeArguments();
}

class HomePage extends StatelessWidget {
  final HomeArguments arguments;

  const HomePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit();
      },
      child: HomeChildPage(
        arguments: arguments,
      ),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  final HomeArguments arguments;

  const HomeChildPage({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final HomeCubit _cubit;

  int bottomBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _cubit.onChangeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Trang chủ",
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
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus ||
          previous.isShowMoney != current.isShowMoney,
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
                if (state.profile![Constant.TYPE] == Constant.CUSTOMER) ...[
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mã QR của tôi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF141ED2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WidgetCustom.cardCustom(
                    widget: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: QrImageView(
                          data: state.username!,
                          version: QrVersions.auto,
                          size: MediaQuery.of(context).size.width * 6 / 10,
                        ),
                      ),
                    ),
                  ),
                ] else...[
                  const SizedBox(height: 10),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF141ED2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetCustom.cardCustom(
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person_rounded,
                                color: Colors.blue,
                              ),
                              WidgetCustom.textView(
                                text: "${state.profile!['name']}",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone_android,
                                color: Colors.pink,
                              ),
                              WidgetCustom.textView(
                                text: "${state.profile!['phone']}",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.payments,
                                color: Colors.green,
                              ),
                              WidgetCustom.textView(
                                text: state.isShowMoney
                                    ? "${Utils.roundingNumberInteger(number: state.profile!['money'])}đ"
                                    : "******",
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        _cubit.changeIsShowMoney();
                                      },
                                      child: const Icon(Icons.remove_red_eye),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.profile![Constant.TYPE] == Constant.CUSTOMER
                              ? 'Địa điểm ghé thăm gần nhất'
                              : 'Tài xế ghé thăm gần nhất',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF141ED2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _lastVisited(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _lastVisited() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.changeData != current.changeData,
      builder: (context, state) {
        if (state.profile![Constant.LAST_VISITED] != null) {
          Map<String, dynamic>? data =
              Map<String, dynamic>.from(state.profile![Constant.LAST_VISITED]);
          return WidgetCustom.cardCustom(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailStatisticalPage(
                    arguments: DetailStatisticalArguments(
                        accountInfo: data[Constant.USERNAME],
                    ),
                  ),
                ),
              );
            },
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  WidgetCustom.itemInfo(
                    title: data[Constant.NAME] ?? '',
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WidgetCustom.textView(
                          text: "Địa chỉ: ${data[Constant.ADDRESS] ?? ''}",
                        ),
                        WidgetCustom.textView(
                          text: "SĐT: ${data[Constant.PHONE] ?? ''}",
                        ),
                        WidgetCustom.textView(
                          text:
                              "Thời gian: ${data[Constant.CREATE_DATE] ?? ''}",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            state.profile![Constant.TYPE] == Constant.CUSTOMER
                                ? "+ ${Utils.roundingNumberInteger(number: data[Constant.MONEY]) ?? ''}đ"
                                : "- ${Utils.roundingNumberInteger(number: data[Constant.MONEY]) ?? ''}đ",
                            style: TextStyle(
                              color: state.profile![Constant.TYPE] ==
                                      Constant.CUSTOMER
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isShowDivider: false,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
