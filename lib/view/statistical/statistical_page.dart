import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/model/visited.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/view/detail_statistical/detail_statistical_page.dart';
import 'package:untitled/widget/widget_custom.dart';

import 'statistical_cubit.dart';

class StatisticalArguments {
  StatisticalArguments();
}

class StatisticalPage extends StatelessWidget {
  final StatisticalArguments arguments;

  const StatisticalPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return StatisticalCubit();
      },
      child: const StatisticalChildPage(),
    );
  }
}

class StatisticalChildPage extends StatefulWidget {
  const StatisticalChildPage({Key? key}) : super(key: key);

  @override
  State<StatisticalChildPage> createState() => _StatisticalChildPageState();
}

class _StatisticalChildPageState extends State<StatisticalChildPage> {
  late final StatisticalCubit _cubit;

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
    return BlocBuilder<StatisticalCubit, StatisticalState>(
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
          return Column(
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
                    "Thống kê",
                    style: TextStyle(
                        color: Colors.green.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Text(
              //           'Tổng quan',
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w400,
              //             color: Color(0xFF141ED2),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                                'Số lần dẫn đoàn',
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
                              '${(state.listHistory ?? []).length}',
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
              // WidgetCustom.cardCustom(
              //   widget: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: Row(
              //             children: [
              //               const Icon(
              //                 Icons.car_crash,
              //                 color: Colors.blue,
              //               ),
              //               WidgetCustom.textView(
              //                 text:
              //                     "Số lần ghé thăm: ${(state.listHistory ?? []).length}",
              //               ),
              //             ],
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: Row(
              //             children: [
              //               const Icon(
              //                 Icons.payments,
              //                 color: Colors.green,
              //               ),
              //               WidgetCustom.textView(
              //                 text:
              //                     "Tiền được tri ân: ${Utils.roundingNumberInteger(number: state.totalMoney)}đ",
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Text(
              //           'Lịch sử ghé thăm',
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w400,
              //             color: Color(0xFF141ED2),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.green_2,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.list_alt,
                              color: AppTheme.green_text,
                              size: 48,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Lịch sử dẫn đoàn',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.green_text,
                                    ),
                                  ),
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
                              data: state.listHistory![
                                  state.listHistory!.length - index - 1],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
    return BlocBuilder<StatisticalCubit, StatisticalState>(
      buildWhen: (previous, current) =>
          previous.changeData != current.changeData,
      builder: (context, state) {
        return WidgetCustom.cardCustom(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailStatisticalPage(
                  arguments: DetailStatisticalArguments(
                    accountInfo: data.username!,
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
                  title: data.name ?? '',
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetCustom.textView(
                        text: "Địa chỉ: ${data.address ?? ''}",
                      ),
                      WidgetCustom.textView(
                        text: "SĐT: ${data.phone ?? ''}",
                      ),
                      WidgetCustom.textView(
                        text: "Thời gian: ${data.createDate ?? ''}",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "+ ${Utils.roundingNumberInteger(number: data.money) ?? ''}đ",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "+ ${Utils.roundingNumberInteger(number: data.score) ?? ''} điểm",
                          style: const TextStyle(
                            color: Colors.blue,
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
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
