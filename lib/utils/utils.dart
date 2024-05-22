import 'package:flutter/services.dart';

class Utils {
  static String? roundingNumberDouble({
    required double? number, // số thập phân
    required int decimalPlaces, // Số chữ số sau dấu thập phân muốn làm tròn
  }) {
    try {
      if (number == null) {
        return null;
      }
      String strConvert = number.toStringAsFixed(decimalPlaces);
      String result = '';
      int positionDots = number.toString().indexOf('.');
      if (positionDots == -1) {
        positionDots = strConvert.length;
      }
      int countVariable = 0;
      for (int i = positionDots - 1; i >= 0; i--) {
        if (countVariable == 2 && i != 0) {
          result = ",${strConvert[i]}$result";
        } else {
          result = "${strConvert[i]}$result";
        }
        countVariable++;
        if (countVariable == 3) {
          countVariable = 0;
        }
      }
      if (positionDots != strConvert.length) {
        int decimalPart = int.parse(
            strConvert.substring(positionDots + 1, strConvert.length));
        if (decimalPart != 0) {
          result += strConvert.substring(positionDots, strConvert.length);
        }
      }
      return result;
    } catch (e) {
      return null;
    }
  }

  static String? roundingNumberInteger({
    required int? number, // số nguyên
  }) {
    try {
      if (number == null) {
        return null;
      }
      String strConvert = number.toString();
      String result = '';
      int countVariable = 0;
      for (int i = strConvert.length - 1; i >= 0; i--) {
        if (countVariable == 2 && i != 0) {
          result = ",${strConvert[i]}$result";
        } else {
          result = "${strConvert[i]}$result";
        }
        countVariable++;
        if (countVariable == 3) {
          countVariable = 0;
        }
      }
      return result;
    } catch (e) {
      return null;
    }
  }

  static double? parseDouble({
    required String? value, // số thập phân
  }) {
    try {
      if (value == null) {
        return null;
      }
      double result = double.parse(value);
      return result;
    } catch (e) {
      return null;
    }
  }

  static List<TextInputFormatter> getInputFormatters({
    required int maxLength,
    List<TextInputFormatter>? inputFormatters
  }) {
    List<TextInputFormatter> result = [];
    result.add(LengthLimitingTextInputFormatter(maxLength));
    for (TextInputFormatter item in inputFormatters??[]) {
      result.add(item);
    }
    return result;
  }

}
