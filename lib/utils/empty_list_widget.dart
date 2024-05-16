import 'package:flutter/material.dart';
import 'package:untitled/utils/app_theme.dart';

class EmptyListWidget extends StatelessWidget {
  final RefreshCallback? onRefresh;
  final String? content;
  final double? heightSpacer;
  final String? image;
  final bool visibleImage;
  final MainAxisAlignment? mainAxis;
  final double? heightSpacerTop;

  const EmptyListWidget({
    Key? key,
    @required this.onRefresh,
    this.heightSpacer,
    this.content,
    this.image,
    this.visibleImage = false,
    this.mainAxis,
    this.heightSpacerTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh!,
      color: AppTheme.blueText,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: mainAxis ?? MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: heightSpacerTop ?? 0),
                    Visibility(
                      visible: visibleImage && (image ?? '').isNotEmpty,
                      child: Image.asset(image ?? ''),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Text(
                        content ?? 'Không có dữ liệu',
                        style: AppTheme.blackS18W400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: heightSpacer ?? 80),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
