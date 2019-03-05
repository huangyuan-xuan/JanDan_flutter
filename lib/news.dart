import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'public_widget.dart';

class News extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }
}

class NewsState extends State<News> {
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
        if (!isLoadMore) {
          pageNumber = 1;
        }
      });
    }
    var httpClient = new HttpClient();
    String dataUrl =
        "http://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,excerpt,comment_count,comment_status,custom_fields&custom_fields=thumb_c,views&dev=1&page=$pageNumber";
    var request = await httpClient.getUrl(Uri.parse(dataUrl));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      setState(() {
        isLoading = false;
        pageNumber++;
        if (isLoadMore) {
          widgets.addAll(json.decode(jsonStr)["posts"]);
        } else {
          widgets = json.decode(jsonStr)["posts"];
          print(widgets.length);
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

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 30,
                  padding: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${data["title"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${data["author"]["nickname"]}"),
                      Text("${data["date"]}"),
                      Text("${data["comment_count"]}评论"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.network(
                widgets[i]["custom_fields"]["thumb_c"][0],
                fit: BoxFit.fill,
                height: 60,
              ),
            ),
          )
        ],
      );
    } else {
      return getOnLoadMoreWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        onRefresh: () => _loadData(false),
        child: new ListView.builder(
            controller: _scrollController,
            itemCount: widgets.length + 1,
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  getRow(position),
                  Divider(),
                ],
              );
            }));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
