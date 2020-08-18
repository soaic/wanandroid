import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/home_page.dart';
import 'package:wanandroid/ui/page/personal_page.dart';
import 'package:wanandroid/ui/page/wx_article_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final pageList = [
    HomePage(),
    WxArticlePage(),
    PersonalPage()
  ];

  final bottomItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), title: Text('公众号')),
    BottomNavigationBarItem(
        icon: Icon(Icons.people), title: Text('我'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Theme(
          isMaterialAppTheme: true,
          data: Theme.of(context).copyWith(
            //去掉水波纹
            highlightColor: Color.fromRGBO(0, 0, 0, 0),
            splashColor: Color.fromRGBO(0, 0, 0, 0),
          ),
          child: BottomNavigationBar(
            items: bottomItem,
            currentIndex: _currentIndex,
            fixedColor: Theme.of(context).accentColor,
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            unselectedFontSize: 12,
            selectedFontSize: 12,
          ),
        ),
        body: IndexedStack(index: _currentIndex, children: pageList)  // IndexedStack 层叠布局，每次切换页面时控件为活动状态
      );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
