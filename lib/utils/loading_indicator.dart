import 'package:flutter/material.dart';
import 'package:untitled/utils/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppTheme.blueText,
          ),
        ),
      ),
    );
  }
}
