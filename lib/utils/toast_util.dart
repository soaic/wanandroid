import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(BuildContext context, String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }
}
