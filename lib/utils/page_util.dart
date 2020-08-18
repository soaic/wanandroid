import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/widget/web_scaffold.dart';
import 'package:wanandroid/utils/object_util.dart';

class PageUtil {
  static void pushPage(
    BuildContext context,
    Widget page, {
    bool needLogin = false,
  }) {
    if (context == null || page == null) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void replacePage(
      BuildContext context,
      Widget page, {
        bool needLogin = false,
      }) {
    if (context == null || page == null) return;
    Navigator.pushAndRemoveUntil(
        context, new CupertinoPageRoute(builder: (context) => page), (route) => route == null);
  }

  static void pushWeb(BuildContext context,
      { String title, String url, String userAgent, OnWebViewListener onWebViewListener}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title);
    } else {
      Navigator.push(context, new CupertinoPageRoute<void>(
          builder: (ctx) =>
          new WebScaffold(
              title: title,
              url: url,
              userAgent: userAgent,
              onWebViewListener: onWebViewListener
          ))
      );
    }
  }

  static void pushDialog(
      BuildContext context,
      Widget dialog) {
    if (context == null || dialog == null) return;
    Navigator.push(
        context, _PopRoute(
        child: dialog
    ));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {

  }
}

// 为了去掉 dialog 灰色背景
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  _PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}