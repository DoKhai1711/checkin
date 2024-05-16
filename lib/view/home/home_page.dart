import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    return QrImageView(
      data: '1234567890',
      version: QrVersions.auto,
      size: 200.0,
    );
  }


  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
