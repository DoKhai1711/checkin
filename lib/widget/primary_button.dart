import 'package:flutter/material.dart';
import 'package:untitled/utils/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final String? title;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? color, borderColor;

  const PrimaryButton({
    Key? key,
    this.borderRadius,
    this.title,
    this.titleStyle,
    this.onTap,
    this.padding,
    this.height,
    this.color,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            color: color ?? Colors.red,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: titleStyle ?? AppTheme.whiteS14W600,
            ),
          ),
        ),
      ),
    );
  }
}
