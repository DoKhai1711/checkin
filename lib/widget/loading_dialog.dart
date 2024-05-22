import 'package:flutter/material.dart';
import 'package:untitled/utils/app_theme.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoadingDialog());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppTheme.red,
          ),
        ),
      ),
    );
  }
}

class LoadingDialogTransparent extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialogTransparent(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialogTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          color: Colors.transparent,
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(12.0),
          child: const RepaintBoundary(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class LoadingDialogWhiteBackground extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialogTransparent(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialogWhiteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.red,
            ),
          ),
        ),
      ),
    );
  }
}
