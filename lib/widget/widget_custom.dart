import 'package:flutter/material.dart';

class WidgetCustom {
  static Widget cardCustom({
    required Widget widget,
    Color? color,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(
          top: 14,
          left: 16,
          right: 16,
          bottom: 14
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFBDBDBD),
            offset: Offset(2, 2),
            blurRadius: 8,
          )
        ],
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          if (onTap!=null) {
            onTap();
          }
        },
        child: widget,
      ),
    );
  }
}