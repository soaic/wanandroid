import 'package:flutter/material.dart';
import 'package:wanandroid/model/user_entity.dart';
import 'package:wanandroid/net/request/user_request.dart';
import 'package:wanandroid/ui/page/login_page.dart';
import 'package:wanandroid/ui/page/score_page.dart';
import 'package:wanandroid/ui/page/theme_page.dart';
import 'package:wanandroid/ui/widget/loding_dialog.dart';
import 'package:wanandroid/utils/json_util.dart';
import 'package:wanandroid/utils/page_util.dart';
import 'package:wanandroid/utils/sp_util.dart';
import 'package:wanandroid/utils/toast_util.dart';

class PersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonalPageState();
  }
}

class PersonalPageState extends State<PersonalPage> {
  String userName = "";
  int coinCont = 0;
  int level = 0;
  String rank = "";

  @override
  void initState() {
    super.initState();
    UserRequest.getScoreInfo().then((value) {
      setState(() {
        coinCont = value.coinCount;
        level = value.level;
        rank = value.rank;
      });
    });
    String userInfo = SPUtil.get("userInfo", "");
    if (userInfo != "") {
      UserEntity userEntity = UserEntity.fromJson(JsonUtil.decode(userInfo));
      setState(() {
        userName = userEntity.username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              color: Theme.of(context).brightness == Brightness.light ? Colors.indigoAccent : Colors.indigo,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hello $userName!",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "积分:$coinCont Lv$level 排名:$rank",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            buildItem("我的收藏", () {}),
            Divider(
              height: 1,
            ),
            buildItem("我的积分", () {
              PageUtil.pushPage(context, ScorePage());
            }),
            Divider(
              height: 1,
            ),
            buildItem("深色模式", () {
              PageUtil.pushPage(context, ThemePage());
            }),
            Divider(
              height: 1,
            ),
            buildItem("退出", showLogoutDialog),
            Divider(
              height: 1,
            ),
          ]),
    );
  }

  Widget buildItem(String title, GestureTapCallback onTap) {
    return InkWell(
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 14),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              )
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  void logout() {
    LoadingDialog.show(context, "退出中...");
    UserRequest.logout().then((value) {
      SPUtil.remove("userInfo").then((value) {
        return SPUtil.remove("cookies");
      }).then((value) {
        LoadingDialog.dismiss(context);
        PageUtil.replacePage(context, LoginPage());
      });
    }).catchError((onError) {
      LoadingDialog.dismiss(context);
      ToastUtil.show(context, onError.toString());
    });
  }

  Future<bool> showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("确定退出吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("退出"),
              onPressed: () {
                Navigator.of(context).pop();
                logout();
              },
            ),
          ],
        );
      },
    );
  }
}
