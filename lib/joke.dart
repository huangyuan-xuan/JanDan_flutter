import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Joke extends StatefulWidget {
  Joke({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _JokeState();
  }
}

class _JokeState extends State<Joke> {
  List widgets = [];
  var pageNumber = 1;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

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
      });
    }
    var httpClient = new HttpClient();
    if (!isLoadMore) {
      pageNumber = 1;
    }
    String dataUrl =
        "http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=$pageNumber";
    var request = await httpClient.getUrl(Uri.parse(dataUrl));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      setState(() {
        isLoading = false;
        pageNumber++;
        if (isLoadMore) {
          widgets.addAll(json.decode(jsonStr)["comments"]);
        } else {
          widgets = json.decode(jsonStr)["comments"];
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
      return new Card(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widgets[i]["comment_author"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widgets[i]["comment_date"]}",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                "${widgets[i]["text_content"]}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text("OO"),
                            Text("${widgets[i]["vote_positive"]}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("XX"),
                      Text("${widgets[i]["vote_negative"]}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("吐槽"),
                      Text("${widgets[i]["vote_negative"]}"),
                    ],
                  ),
                  Icon(Icons.more_horiz),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return _getOnLoadMoreWidget();
    }
  }

  // 加载更多时显示的组件
  Widget _getOnLoadMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...     ',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
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
