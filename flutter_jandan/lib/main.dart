import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'view/my_drawer.dart';
import 'view/girls_image_with_bloc.dart';
import 'view/news_with_bloc.dart';
import 'view/joke_with_bloc.dart';
import 'view/bored_image_with_bloc.dart';

import 'package:flutter_jandan/blocs/bloc_provider.dart';
import 'package:flutter_jandan/blocs/application_bloc.dart';
import 'package:flutter_jandan/blocs/girls_image_bloc.dart';
import 'package:flutter_jandan/blocs/bored_bloc.dart';
import 'package:flutter_jandan/blocs/joke_bloc.dart';
import 'package:flutter_jandan/blocs/news_bloc.dart';

//void main() {
//  debugPaintSizeEnabled = true;
//  runApp(_widgetForRoute(window.defaultRouteName));
//runApp(App());
//}

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;
  return runApp(BLoCProvider<ApplicationBloc>(
    bloc: ApplicationBloc(),
    child: _widgetForRoute(window.defaultRouteName),
  ));
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

          BLoCProvider<NewsBLoC>(
            bloc: NewsBLoC(),
            child: NewsWithBLoC(),
          ),

          BLoCProvider<BoredBLoC>(
            bloc: BoredBLoC(),
            child: BoredImageWithBLoC(),
          ),
          BLoCProvider<JokeBLoC>(
            bloc: JokeBLoC(),
            child: JokeWithBLoC(),
          ),

          BLoCProvider<GirlsImageBLoC>(
            bloc: GirlsImageBLoC(),
            child: GirlsImageWithBLoC(),
          )
        ],
      ),
    );
  }
}
