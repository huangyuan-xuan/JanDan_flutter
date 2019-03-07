import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:io';
import 'dart:convert';
import 'package:jandan_flutter/view/public_widget.dart';
import 'package:jandan_flutter/bean/bored_image_bean.dart';
import 'tap_change_color.dart';

class BoredImage extends StatefulWidget {
  @override
  BoredImageState createState() {
    return BoredImageState();
  }
}

class BoredImageState extends State<BoredImage> {
  List<BoredImageBean> widgets = [];
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
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=$pageNumber";

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      var boredImageModel = BoredImageModel.fromJson(json.decode(jsonStr));
      setState(() {
        pageNumber++;
        isLoading = false;
        if (isLoadMore) {
          widgets.addAll(boredImageModel.comments);
        } else {
          widgets = boredImageModel.comments;
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
              Text(
                "${data.author}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data.date}",
                style: TextStyle(fontSize: 12),
              ),
              Offstage(
                offstage: data.content == null ||
                    data.content .toString().trim().length == 0,
                child: Text(
                  "${data.content.toString().trim()}",
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.2),
                ),
              ),
              FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage, image: data.pics[0]),
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
