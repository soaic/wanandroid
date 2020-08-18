import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/article_entity.dart';
import 'package:wanandroid/model/banner_entity.dart';
import 'package:wanandroid/net/request/home_request.dart';
import 'package:wanandroid/ui/widget/animated_rotation_box.dart';
import 'package:wanandroid/ui/widget/gradient_circular_progress_indicator.dart';
import 'package:wanandroid/ui/widget/infinite_listview.dart';
import 'package:wanandroid/ui/widget/swiper.dart';
import 'package:wanandroid/ui/widget/web_scaffold.dart';
import 'package:wanandroid/ui/widget/widgets.dart';
import 'package:wanandroid/utils/page_util.dart';
import 'package:wanandroid/utils/object_util.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<BannerEntity> bannerList;
  int _current = 0;
  bool _isInit = false;

  Widget buildBanner(BuildContext context) {
    if (ObjectUtil.isEmpty(bannerList)) {
      return new Container(height: 0.0);
    }
    return new AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.bottomEnd,
        circular: true,
        interval: const Duration(seconds: 5),
        //indicator: CircleSwiperIndicator(),
        indicator: NumberSwiperIndicator(),
        children: bannerList.map((bannerModel) {
          return new InkWell(
            onTap: () {
              PageUtil.pushPage(context,
                  WebScaffold(title: bannerModel.title, url: bannerModel.url));
            },
            child: new CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: bannerModel.imagePath,
              placeholder: (context, url) => new ProgressView(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: InfiniteListView<ArticleEntity>(
      separatorBuilder: (list, index, ctx) {
        return Divider(height: 1);
      },
      headerBuilder: (list, context) {
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildBanner(context),
          ],
        );
      },
      itemBuilder: (List<ArticleEntity> list, int index, BuildContext ctx) {
        var subtitle = "";
        if (list[index].shareUser.isNotEmpty) {
          subtitle += "分享人：${list[index].shareUser}";
        } else if (list[index].author.isNotEmpty) {
          subtitle += "作者：${list[index].author}";
        }
        var date = " 时间：${list[index].niceDate}";

        return ListTile(
            title: Text("${list[index].title}"),
            subtitle:
            Row(
                children: <Widget>[
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
      },
      onRetrieveData: (int page, List items, bool refresh) {
        if (!_isInit || refresh) {
          _current = 0;
          //下拉刷新
          return HomeRequest.getBanner().then((value) {
            bannerList = value;
            return HomeRequest.getArticleList(page: _current);
          }).then((value) {
            items.clear();
            if (value != null) {
              if (value.length <= 0) return false;
              items.addAll(value);
              _current += value.length;
            }
            _isInit = true;
            return true;
          });
        } else {
          // 上拉加载
          return HomeRequest.getArticleList(page: _current).then((value) {
            if (value != null && value.length > 0) {
              items.addAll(value);
              _current += value.length;
              return true;
            } else {
              return false;
            }
          });
        }
      },
      loadingBuilder: (context) {
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
      },
      noMoreViewBuilder: (list, context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "共${list.length}条",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    ));
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
