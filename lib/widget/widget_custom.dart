import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/utils/app_theme.dart';
import 'package:untitled/utils/utils.dart';

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

  static Widget textView({
    required String? text,
    bool? visible,
  }) {
    return Visibility(
      visible: visible ?? text != null,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 4,
          bottom: 8,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Text(
              text ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF616161),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget itemInfo({
    required String title,
    required Widget widget,
    bool isShowDivider = true,
    bool isRequired = false,
    bool hasIcon = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: titleItem(
                text: title,
                isRequired: isRequired,
                hasIcon: hasIcon,
              ),
            ),
          ),
        ),
        widget,
        if (isShowDivider) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: dividerCustom(),
          )
        ] else ...[
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  static Widget titleItem({
    required String text,
    bool hasIcon = false,
    bool isRequired = false,
  }) {
    return Row(
      children: [
        if (hasIcon) ...[
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.circle,
              size: 8,
              color: AppTheme.blueText,
            ),
          ),
        ],
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: text),
                if (isRequired) ...[
                  const TextSpan(text: ' '),
                  const TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ]
              ],
            ),
            style: hasIcon
                ? AppTheme.blackS18W400
                : AppTheme.greyS18W400,
            maxLines: null,
          ),
        ),
      ],
    );
  }

  static Widget dividerCustom() {
    return SizedBox(
      height: 15,
      child: Transform.translate(
        offset: const Offset(0, -7),
        child: const Text(
          "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
          style: TextStyle(color: AppTheme.greyCircle, fontSize: 18),
          maxLines: 1,
        ),
      ),
    );
  }

  static Widget textField({
    TextEditingController? controller,
    int maxLength = 255,
    int? maxLines = 1,
    String hintText = "",
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChange,
    String? errorText,
    String? initialValue,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        maxLines: maxLines,
        enabled: enabled,
        cursorColor: AppTheme.blackText.withOpacity(0.5),
        style: AppTheme.blackS18W400,
        keyboardType: keyboardType,
        inputFormatters: Utils.getInputFormatters(
          maxLength: maxLength,
          inputFormatters: inputFormatters,
        ),
        onChanged: (value) {
          if (onChange!=null) {
            onChange(value);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(
            10.0,
            10.0,
            20.0,
            10.0,
          ),
          hintText: hintText,
          hintStyle: AppTheme.greyHintS16W400,
          errorText: errorText,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            borderSide: BorderSide(
              color: AppTheme.greyIndicator,
              width: 1.5,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            borderSide: BorderSide(
              color: AppTheme.greyIndicator,
              width: 1.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            borderSide: BorderSide(
              color: AppTheme.greyIndicator,
              width: 1.5,
            ),
          ),
          suffixIcon: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                )),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }

}