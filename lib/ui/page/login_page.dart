import 'package:flutter/material.dart';
import 'package:wanandroid/net/request/user_request.dart';
import 'package:wanandroid/ui/page/register_page.dart';
import 'package:wanandroid/ui/page/main_page.dart';
import 'package:wanandroid/ui/widget/loding_dialog.dart';
import 'package:wanandroid/utils/page_util.dart';
import 'package:wanandroid/utils/toast_util.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("登录"),
       centerTitle: true,
     ),
      body: Material(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _unameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: double.infinity, // 宽度无限，跟父控件保持一致
                  child: RaisedButton(child: Text("登录"), onPressed: login),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity, // 宽度无限，跟父控件保持一致
                  child: RaisedButton(child: Text("注册"), onPressed: register),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    String userName = _unameController.text;
    String password = _pwdController.text;
    LoadingDialog.show(context, "登录中...");
    UserRequest.login(userName, password).then((value) {
      LoadingDialog.dismiss(context);
      PageUtil.replacePage(context, new MainPage());
    }).catchError((onError){
      LoadingDialog.dismiss(context);
      ToastUtil.show(context, onError.toString());
    });
  }

  void register() {
    PageUtil.pushPage(context, RegisterPage());
  }
}
