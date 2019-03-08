import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:my_flutter/view/public_widget.dart';
import 'package:my_flutter/bean/joke_bean.dart';
import 'tap_change_color.dart';

class Joke extends StatefulWidget {
  Joke({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _JokeState();
  }
}

class _JokeState extends State<Joke> with TickerProviderStateMixin {
  List<JokeBean> widgets = [];

  var pageNumber = 1;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(true);
      }
    });
    _loadData(false);
  }

  Future<void> _loadData(bool isLoadMore) async {
    if (isLoading) {
      return null;
    } else {
      setState(() {
        isLoading = true;
        if (!isLoadMore) {
          pageNumber = 1;
        }
      });
    }
    var httpClient = new HttpClient();
    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=$pageNumber";
    var request = await httpClient.getUrl(Uri.parse(dataUrl));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      var jokeModel = JokeModel.fromJson(json.decode(jsonStr));
      setState(() {
        isLoading = false;
        pageNumber++;
        if (isLoadMore) {
          widgets.addAll(jokeModel.comments);
        } else {
          widgets = jokeModel.comments;
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "请求失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black12);
    }
  }




  Widget getRow(int i) {
    if (i < widgets.length) {
      var data = widgets[i];

      animationController = new AnimationController(
          vsync: this, duration: const Duration(seconds: 3));

      animation = new Tween(begin: 14.0, end: 30.0).animate(animationController)
        ..addStatusListener((state) {
          Fluttertoast.showToast(msg: state.toString());
        })
        ..addListener(() {
          setState(() {});
        });

      var textColor = Colors.black54;

      return new Card(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widgets[i].author}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                child: Text(
                  "${widgets[i].date}",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.1),
                ),
              ),
              Text(
                "${widgets[i].content}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TapChangeColorText(text: "OO ${data.votePositive}"),
                  TapChangeColorText(text: "XX ${data.voteNegative}"),
                  Text("吐槽 ${data.subCommentCount}"),
                  Icon(Icons.more_horiz),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return getOnLoadMoreWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => _loadData(false),
        child: new ListView.builder(
            controller: _scrollController,
            itemCount: widgets.length + 1,
            itemBuilder: (BuildContext context, int position) {
              return getRow(position);
            }));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
