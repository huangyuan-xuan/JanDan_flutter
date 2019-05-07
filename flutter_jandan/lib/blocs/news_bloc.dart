import 'bloc_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_jandan/bean/news_bean.dart';
import 'package:flutter_jandan/http_util.dart';

class NewsBLoC extends BLoCBase {
  StreamController<List<NewsBean>> _resultController = StreamController<List<NewsBean>>.broadcast();
  Sink<List<NewsBean>> get inResultList => _resultController.sink;
  Stream<List<NewsBean>> get outResultList => _resultController.stream;

  StreamController<bool> _indexController = StreamController<bool>.broadcast();
  Sink<bool> get inNewsIndex => _indexController.sink;

  List<NewsBean> datas = [];
  var pageNumber = 1;

  NewsBLoC() {
    _indexController.stream.listen(_handleIndex);
    _resultController.addError(
        (error) => print("_newsResultController error->${error.toString()}"));
    _indexController.addError(
        (error) => print("_newsIndexController error->${error.toString()}"));
  }

  void _handleIndex(bool isLoadMore) async {
    if (isLoadMore) {
      pageNumber++;
    } else {
      pageNumber = 1;
    }

    HttpUtils().dio.get("", queryParameters: {
      "oxwlxojflwblxbsapi": "get_recent_posts",
      "include":
          "url,date,tags,author,title,excerpt,comment_count,comment_status,custom_fields",
      "custom_fields": "thumb_c,views",
      "dev": "1",
      "page": pageNumber
    });

    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,excerpt,comment_count,comment_status,custom_fields&custom_fields=thumb_c,views&dev=1&page=$pageNumber";
    try {
      Response<Map<String, dynamic>> response = await Dio().get(dataUrl);
      if (response.statusCode == 200) {
        var newsModel = NewsModel.fromJson(response.data);
        if (isLoadMore) {
          datas.addAll(newsModel.posts);
        } else {
          datas = newsModel.posts;
        }
        _resultController.add(datas);
      } else {
        showError();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {}
}
