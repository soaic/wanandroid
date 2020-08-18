import 'package:flutter/material.dart';
import 'package:wanandroid/net/request/user_request.dart';
import 'package:wanandroid/ui/page/login_page.dart';
import 'package:wanandroid/ui/widget/loding_dialog.dart';
import 'package:wanandroid/utils/page_util.dart';
import 'package:wanandroid/utils/toast_util.dart';
import 'package:wanandroid/utils/utils.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }

}

class RegisterPageState extends State<RegisterPage>{

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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

  void register() {
    String userName = _unameController.text;
    String password = _pwdController.text;
    Utils.hideSoftKeyBoard(context);
    LoadingDialog.show(context, "注册中...");
    UserRequest.register(userName, password).then((value) {
      LoadingDialog.dismiss(context);
      PageUtil.replacePage(context, new LoginPage());
    }).catchError((onError){
      LoadingDialog.dismiss(context);
      ToastUtil.show(context, onError);
    });
  }
}

