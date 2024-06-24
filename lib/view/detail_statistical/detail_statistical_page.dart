import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/model/visited.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'detail_statistical_cubit.dart';

class DetailStatisticalArguments {
  String accountInfo;

  DetailStatisticalArguments({
    required this.accountInfo,
  });
}

class DetailStatisticalPage extends StatelessWidget {
  final DetailStatisticalArguments arguments;

  const DetailStatisticalPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailStatisticalCubit();
      },
      child: DetailStatisticalChildPage(
        arguments: arguments,
      ),
    );
  }
}

class DetailStatisticalChildPage extends StatefulWidget {
  final DetailStatisticalArguments arguments;

  const DetailStatisticalChildPage({required this.arguments, Key? key})
      : super(key: key);

  @override
  State<DetailStatisticalChildPage> createState() =>
      _DetailStatisticalChildPageState();
}

class _DetailStatisticalChildPageState
    extends State<DetailStatisticalChildPage> {
  late final DetailStatisticalCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(
      accountInfo: widget.arguments.accountInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "Thông tin chi tiết",
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
    return BlocBuilder<DetailStatisticalCubit, DetailStatisticalState>(
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
                opacity: 0.5,
                child: Image.asset(
                  "assets/img/bg_sapa.jpg",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tổng quan',
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
                                  Icons.car_crash,
                                  color: Colors.blue,
                                ),
                                WidgetCustom.textView(
                                  text:
                                      "Số lần ghé thăm: ${(state.listHistory ?? []).length}",
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
                                  text:
                                      "Tiền tri ân: ${Utils.roundingNumberInteger(number: state.totalMoney)}đ",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Lịch sử ghé thăm',
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: (state.listHistory ?? []).length,
                      itemBuilder: (context, index) {
                        return _visited(
                          data: state
                              .listHistory![state.listHistory!.length - index - 1],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _visited({
    required Visited data,
  }) {
    return BlocBuilder<DetailStatisticalCubit, DetailStatisticalState>(
      buildWhen: (previous, current) =>
          previous.changeData != current.changeData,
      builder: (context, state) {
        return WidgetCustom.cardCustom(
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WidgetCustom.itemInfo(
                  title: data.createDate ?? '',
                  widget: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${Utils.roundingNumberInteger(number: data.money) ?? ''}đ",
                              style: TextStyle(
                                color: state.profile![Constant.TYPE] ==
                                        Constant.EMPLOYEE
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        if (state.profile![Constant.TYPE] == Constant.EMPLOYEE) ...[
                          Row(
                            children: [
                              Text(
                                "${Utils.roundingNumberInteger(number: data.score) ?? ''} điểm",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                  isShowDivider: false,
                ),
              ],
            ),
          ),
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
