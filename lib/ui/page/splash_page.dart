import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/login_page.dart';
import 'package:wanandroid/ui/page/main_page.dart';
import 'package:wanandroid/utils/page_util.dart';
import 'package:wanandroid/utils/sp_util.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 2)).then((value) {
      return SPUtil.get("cookies", "");
    }).then((value) {
      if (value == "") {
        PageUtil.replacePage(context, LoginPage());
      } else {
        PageUtil.replacePage(context, MainPage());
      }
    });

    return new Material(
      child: Center(
        child: Text("Loading..."),
      ),
    );
  }
}
