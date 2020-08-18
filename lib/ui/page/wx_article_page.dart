import 'package:flutter/material.dart';
import 'package:wanandroid/model/wx_article_entity.dart';
import 'package:wanandroid/net/request/article_request.dart';
import 'package:wanandroid/ui/page/article_list_page.dart';
import 'package:wanandroid/ui/widget/infinite_listview.dart';
import 'package:wanandroid/utils/page_util.dart';

class WxArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WxArticlePageState();
  }
}

class WxArticlePageState extends State<WxArticlePage> {
  bool _isInit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("公众号"),
      ),
      body: InfiniteListView<WxArticleEntity>(
          onRetrieveData: (page, items, refresh) {
            return ArticleRequest.getWxArticle().then((value) {
              if (!_isInit || refresh) {
                items.clear();
                if (value != null) {
                  if (value.length <= 0) return false;
                  items.addAll(value);
                }
                _isInit = true;
              }
              return false;
            });
          },
          itemBuilder: (List<WxArticleEntity> list, index, ctx) {
            return ListTile(
              title: Text(list[index].name),onTap: () {
                PageUtil.pushPage(context, new ArticleListPage(list[index].name, list[index].id));
              },
            );
          },
          loadingBuilder: null,
          separatorBuilder: (list, index, ctx) {
            return Divider(height: 1);
          }),
    );
  }
}
