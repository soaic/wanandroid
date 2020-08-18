import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/main.dart';
import 'package:wanandroid/utils/log_util.dart';
import 'package:wanandroid/utils/sp_util.dart';

class ThemePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new ThemePageState();
  }

}

class ThemePageState extends State<ThemePage> {

  @override
  void initState() {
//    SPUtil().get("isDartMode", false).then((value) {
//      setState(() {
//        LogUtil.v("dart : $value");
//        _switchSelected = value;
//      });
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("深色模式"),
        centerTitle: true,
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("浅色模式"),
              onTap: () {
                setMode(0);
              },
            ),
            Divider(height: 1),
            ListTile(
              title: Text("深色模式"),
              onTap: () {
                setMode(1);
              },
            ),
            Divider(height: 1),
            ListTile(
              title: Text("跟随系统"),
              onTap: () {
                setMode(2);
              },
            ),
            Divider(height: 1),
          ],
        )
      ),
    );
  }

  void setMode(int type) {
    Provider.of<ThemeProvider>(context, listen: false).change(type);
  }
}

