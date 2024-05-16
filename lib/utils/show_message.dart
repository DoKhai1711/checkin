import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      //message to show toast
      toastLength: Toast.LENGTH_LONG,
      //duration for message to show
      gravity: ToastGravity.CENTER,
      //where you want to show, top, bottom
      timeInSecForIosWeb: 1,
      //for iOS only
      //backgroundColor: Colors.red, //background Color for message
      textColor: Colors.white,
      //message text color
      fontSize: 16.0 //message font size
  );
}

void showToastMessageError({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      //message to show toast
      toastLength: Toast.LENGTH_LONG,
      //duration for message to show
      gravity: ToastGravity.CENTER,
      //where you want to show, top, bottom
      timeInSecForIosWeb: 1,
      //for iOS only
      //backgroundColor: Colors.red, //background Color for message
      textColor: Colors.white,
      //message text color
      fontSize: 16.0 //message font size
  );
}

void showToast({Color? color, required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}