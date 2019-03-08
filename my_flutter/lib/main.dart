import 'package:flutter/material.dart';
import 'dart:ui';
import 'view/my_drawer.dart';
import 'view/bored_image.dart';
import 'view/girls_image.dart';
import 'view/joke.dart';
import 'view/news.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(_widgetForRoute(window.defaultRouteName));
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'main':
      return App();
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "flutter demo",
      theme: new ThemeData(primaryColor: Colors.black),
      home: new JanDanApp(),
    );
  }
}

class JanDanApp extends StatefulWidget {
  @override
  JanDanAppState createState() {
    return JanDanAppState();
  }
}

class JanDanAppState extends State<JanDanApp>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["新鲜事", "无聊图", "段子", "妹子图"];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("煎蛋"),
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          News(),
          BoredImage(),
          Joke(),
          GirlsImage(),
        ],
      ),
    );
  }
}