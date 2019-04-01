import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jandan/bean/bored_image_bean.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'full_image_with_download.dart';
import 'public_widget.dart';
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
    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=$pageNumber";
    try {
      Response<Map<String, dynamic>> response = await Dio().get(dataUrl);
      if (response.statusCode == 200) {
        var jokeModel = BoredImageModel.fromJson(response.data);

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
        isLoading = false;
        _showError();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _showError() {
    Fluttertoast.showToast(
        msg: "请求失败",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black12);
  }

  viewPic(String imageUri) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new ViewImage(imageUri);
        }));
  }

  Widget _getRow(int i, BuildContext context) {
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
                    data.content.toString().trim().length == 0,
                child: Text(
                  "${data.content.toString().trim()}",
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.2),
                ),
              ),
              GestureDetector(
                child: new CachedNetworkImage(
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  imageUrl:data.pics[0],
                ),
                onTap: () => viewPic(data.pics[0]),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TapChangeColorText(text: "OO ${data.votePositive}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: TapChangeColorText(text: "XX ${data.voteNegative}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text("吐槽 ${data.subCommentCount}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: Icon(Icons.more_horiz),
                    flex: 1,
                  ),
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
          controller: _scrollController,
          itemCount: widgets.length + 1,
          itemBuilder: (BuildContext context, int position) {
            return _getRow(position, context);
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
