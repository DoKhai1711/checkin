import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/constant.dart';
import 'package:untitled/utils/empty_list_widget.dart';
import 'package:untitled/utils/enum.dart';
import 'package:untitled/utils/loading_indicator.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/view/detail_statistical/detail_statistical_page.dart';
import 'package:untitled/view/pay/pay_page.dart';
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
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

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
                      "Trang chủ",
                      style: TextStyle(
                          color: Colors.green.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 33),
                    )
                  ],
                ),
                if (state.profile![Constant.TYPE] == Constant.CUSTOMER) ...[
                  const SizedBox(height: 10),
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
                ] else ...[
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 400,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ],
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           'Thông tin cá nhân',
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.green_2,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 130,
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
                                  'Họ và tên',
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
                                '${state.profile!['name']}',
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 20),
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
                                  'Số điện thoại',
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
                                '${state.profile!['phone']}',
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
                if (state.profile![Constant.TYPE] == Constant.CUSTOMER) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 20),
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
                                    'Điểm tích luỹ',
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
                                  '${state.profile!['score']}',
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
                ],
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
                //                 Icons.person_rounded,
                //                 color: Colors.blue,
                //               ),
                //               WidgetCustom.textView(
                //                 text: "${state.profile!['name']}",
                //               ),
                //             ],
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 10),
                //           child: Row(
                //             children: [
                //               const Icon(
                //                 Icons.phone_android,
                //                 color: Colors.pink,
                //               ),
                //               WidgetCustom.textView(
                //                 text: "${state.profile!['phone']}",
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
                //                 text: state.isShowMoney
                //                     ? "${Utils.roundingNumberInteger(number: state.profile!['money'])}đ"
                //                     : "******",
                //               ),
                //               Expanded(
                //                 child: Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(right: 16.0),
                //                     child: InkWell(
                //                       splashColor: Colors.transparent,
                //                       focusColor: Colors.transparent,
                //                       highlightColor: Colors.transparent,
                //                       hoverColor: Colors.transparent,
                //                       onTap: () {
                //                         _cubit.changeIsShowMoney();
                //                       },
                //                       child: const Icon(Icons.remove_red_eye),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           state.profile![Constant.TYPE] == Constant.CUSTOMER
                //               ? 'Địa điểm ghé thăm gần nhất'
                //               : 'Tài xế ghé thăm gần nhất',
                //           style: const TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w400,
                //             color: Color(0xFF141ED2),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // _lastVisited(),
              ],
            ),
          );
        }
      },
    );
  }

  // Widget _lastVisited() {
  //   return BlocBuilder<HomeCubit, HomeState>(
  //     buildWhen: (previous, current) =>
  //         previous.changeData != current.changeData,
  //     builder: (context, state) {
  //       if (state.profile![Constant.LAST_VISITED] != null) {
  //         Map<String, dynamic>? data =
  //             Map<String, dynamic>.from(state.profile![Constant.LAST_VISITED]);
  //         return WidgetCustom.cardCustom(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (_) => DetailStatisticalPage(
  //                   arguments: DetailStatisticalArguments(
  //                     accountInfo: data[Constant.USERNAME],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           widget: Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 10),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 WidgetCustom.itemInfo(
  //                   title: data[Constant.NAME] ?? '',
  //                   widget: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       WidgetCustom.textView(
  //                         text: "Địa chỉ: ${data[Constant.ADDRESS] ?? ''}",
  //                       ),
  //                       WidgetCustom.textView(
  //                         text: "SĐT: ${data[Constant.PHONE] ?? ''}",
  //                       ),
  //                       WidgetCustom.textView(
  //                         text:
  //                             "Thời gian: ${data[Constant.CREATE_DATE] ?? ''}",
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 16),
  //                         child: Text(
  //                           state.profile![Constant.TYPE] == Constant.CUSTOMER
  //                               ? "+ ${Utils.roundingNumberInteger(number: data[Constant.MONEY]) ?? ''}đ"
  //                               : "- ${Utils.roundingNumberInteger(number: data[Constant.MONEY]) ?? ''}đ",
  //                           style: TextStyle(
  //                             color: state.profile![Constant.TYPE] ==
  //                                     Constant.CUSTOMER
  //                                 ? Colors.green
  //                                 : Colors.red,
  //                             fontSize: 20,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   isShowDivider: false,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return const SizedBox();
  //       }
  //     },
  //   );
  // }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool isFirst = true;
    controller.scannedDataStream.listen((event) async {
      // setState(() {
      //   result = event.code!;
      // });
      if (isFirst) {
        isFirst = false;
        _cubit.setCustomerNow(event.code!);
        final result = await Navigator.push(
          context,
          PayPage.route(
            arguments: PayArguments(
                code: event.code!
            ),
          ),
        );
        isFirst = true;
      }
    });
  }

  @override
  void dispose() {
    _cubit.close();
    controller!.dispose();
    super.dispose();
  }
}
