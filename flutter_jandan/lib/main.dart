import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'view/my_drawer.dart';
import 'view/bored_image.dart';
import 'view/girls_image.dart';
import 'view/joke.dart';
import 'view/news.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(_widgetForRoute(window.defaultRouteName));
//runApp(App());
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'main':
    case '/':
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
      title: "煎蛋",
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

//  MethodChannel channel;


  @override
  void initState() {

//    channel = const MethodChannel('my_flutter/plugin');
//    channel.setMethodCallHandler(methodHandler);

    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  // 接收原生平台的方法调用处理
  Future methodHandler(MethodCall call) async {
    print("${call.method},${call.arguments}");
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
