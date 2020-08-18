import 'package:flutter/material.dart';
import 'package:wanandroid/utils/page_util.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
          width: 100.0,
          height: 100.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              shadows: [
                //阴影
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: new CircularProgressIndicator(strokeWidth: 2.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context, String text) {
    PageUtil.pushDialog(
      context, new LoadingDialog(text: text),
    );
  }

  static void dismiss(BuildContext context) {
    PageUtil.pop(context);
  }

}
