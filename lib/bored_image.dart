import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';

class BoredImage extends StatefulWidget {
  @override
  BoredImageState createState() {
    return BoredImageState();
  }
}

class BoredImageState extends State<BoredImage> {
  List widgets = [];
  var pageNumber = 1;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(true);
      }
    });
    _loadData(false);
  }

  _loadData(bool isLoadMore) async {
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

    String url =
        "http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=$pageNumber";

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();

      setState(() {
        pageNumber++;
        isLoading = false;
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

  Widget _getRow(int i) {
    if (i < widgets.length) {
      var data = widgets[i];
      return Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${data["comment_author"]}",style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              Text("${data["comment_date"]}",style: TextStyle(
                fontSize: 12
              ),),
              Offstage(
                offstage: data["text_content"] == null ||
                    data["text_content"].toString().trim().length == 0,
                child: Text("${data["text_content"].toString().trim()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.2
                ),
                ),
              ),
              Image.network(data["pics"][0]),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return RefreshIndicator(
      onRefresh: () => _loadData(false),
      child: ListView.builder(
          itemCount: widgets.length + 1,
          itemBuilder: (BuildContext context, int position) {
            return _getRow(position);
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}