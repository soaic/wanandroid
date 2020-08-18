import 'package:flutter/material.dart';
import 'package:wanandroid/model/article_entity.dart';
import 'package:wanandroid/net/request/article_request.dart';
import 'package:wanandroid/ui/widget/animated_rotation_box.dart';
import 'package:wanandroid/ui/widget/gradient_circular_progress_indicator.dart';
import 'package:wanandroid/ui/widget/infinite_listview.dart';
import 'package:wanandroid/ui/widget/web_scaffold.dart';
import 'package:wanandroid/utils/page_util.dart';

class ArticleListPage extends StatefulWidget {
  final String _title;
  final int _id;
  ArticleListPage(this._title, this._id);

  @override
  State<StatefulWidget> createState() {
    return new ArticleListPageState(_title, _id);
  }
}

class ArticleListPageState extends State<ArticleListPage> {
  String _title;
  int _id;
  int _current = 0;
  bool _isInit = false;

  ArticleListPageState(this._title, this._id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: InfiniteListView<ArticleEntity>(
          onRetrieveData: (page, List<ArticleEntity> items, refresh) {
        return ArticleRequest.getWxArticleList(_id, _current).then((value) {
          if (!_isInit || refresh) {
            _current = 0;
            items.clear();
            if (value != null) {
              if (value.length <= 0) return false;
              items.addAll(value);
              _current += value.length;
            }
            _isInit = true;
            return true;
          } else {
            if (value != null && value.length > 0) {
              items.addAll(value);
              _current += value.length;
              return true;
            } else {
              return false;
            }
          }
        });
      }, separatorBuilder: (list, index, ctx) {
        return Divider(height: 1);
      }, itemBuilder: (List<ArticleEntity> list, index, ctx) {
        var subtitle = "";
        if (list[index].shareUser.isNotEmpty) {
          subtitle += "分享人：${list[index].shareUser}";
        } else if (list[index].author.isNotEmpty) {
          subtitle += "作者：${list[index].author}";
        }
        var date = " 时间：${list[index].niceDate}";
        return ListTile(
            title: Text("${list[index].title}"),
            subtitle: Row(children: <Widget>[
              Text("$subtitle"),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("$date"),
              )
            ]),
            onTap: () {
              PageUtil.pushPage(context,
                  WebScaffold(title: list[index].title, url: list[index].link));
            });
      }, noMoreViewBuilder: (e, ctx) {
        return null;
      }, loadingBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedRotationBox(
                duration: Duration(milliseconds: 800),
                child: GradientCircularProgressIndicator(
                  radius: 10.0,
                  colors: [Colors.blue, Colors.lightBlue[50]],
                  value: .8,
                  backgroundColor: Colors.transparent,
                  strokeCapRound: true,
                ),
              ),
              Text("加载更多...")
            ],
          ),
        );
      }),
    );
  }
}
