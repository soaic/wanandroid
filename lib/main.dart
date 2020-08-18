import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/common/global.dart';
import 'package:wanandroid/ui/page/splash_page.dart';
import 'package:wanandroid/utils/sp_util.dart';
import 'package:wanandroid/utils/utils.dart';

void main() {
  Global.init(() {
    runApp(MyApp());
  });
}

class ThemeProvider with ChangeNotifier {
  int get darkMode => _darkMode;

  /// 深色模式 0: 关闭 1: 开启 2: 随系统
  int _darkMode = SPUtil.get("isDartMode", 0);
  void change(int darkMode) async {
    _darkMode = darkMode;
    notifyListeners();
    SPUtil.putInt("isDartMode", _darkMode);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        Utils.hideSoftKeyBoard(context);
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: ThemeProvider()),
          ],
          child: Consumer<ThemeProvider>(
              builder: (context, darkModeProvider, child) {
            return getMaterialApp(darkModeProvider.darkMode);
          })),
    );
  }

  MaterialApp getMaterialApp(int darkMode) {
    ThemeMode themeMode;
    if (darkMode == 1) {
      themeMode = ThemeMode.dark;
    } else if (darkMode == 2) {
      themeMode = ThemeMode.system;
    } else {
      themeMode = ThemeMode.light;
    }
    MaterialApp materialApp = MaterialApp(
        title: "flutter_app",
        themeMode: themeMode,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            accentColor: Colors.indigoAccent,
            appBarTheme: AppBarTheme(color: Colors.indigoAccent)),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.indigo,
            accentColor: Colors.indigoAccent),
        initialRoute: "/",
        routes: {"/": (context) => new SplashPage()});
    return materialApp;
  }
}
