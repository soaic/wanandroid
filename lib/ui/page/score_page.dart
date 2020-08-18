import 'package:flutter/material.dart';
import 'package:wanandroid/model/score_entity.dart';
import 'package:wanandroid/net/request/user_request.dart';
import 'package:wanandroid/ui/widget/animated_rotation_box.dart';
import 'package:wanandroid/ui/widget/gradient_circular_progress_indicator.dart';
import 'package:wanandroid/ui/widget/infinite_listview.dart';

class ScorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScorePageState();
  }
}

class ScorePageState extends State<ScorePage> {
  int _current = 0;
  bool _isInit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的积分"),
        centerTitle: true,
      ),
      body: InfiniteListView<ScoreEntity>(
          onRetrieveData: (page, List<ScoreEntity> items, refresh) {
        return UserRequest.getScoreList(_current).then((value) {
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
      }, itemBuilder: (List<ScoreEntity> list, index, ctx) {
        return ListTile(
          title: Text(list[index].desc),
        );
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
