
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid/utils/sp_util.dart';

class Global {
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    await SPUtil.getInstance();
    callback();
    if (Platform.isAndroid) {
      // 以下两行 设置 android 状态栏为透明的沉浸。
      // 写在组件渲染之后，是为了在渲染后进行 set 赋值，覆盖状态栏，
      // 写在渲染之前 MaterialApp 组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}