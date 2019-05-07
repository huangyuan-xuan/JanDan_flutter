import 'bloc_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_jandan/bean/bored_image_bean.dart';

class BoredBLoC extends BLoCBase{

  StreamController<List<BoredImageBean>> _resultController = StreamController<List<BoredImageBean>>.broadcast();
  Sink<List<BoredImageBean>> get inResult=> _resultController.sink;
  Stream<List<BoredImageBean>> get outResult => _resultController.stream;

  StreamController<bool> _indexController = StreamController<bool>.broadcast();
  Sink<bool> get inBoredIndex => _indexController.sink;

  List<BoredImageBean> datas = [];
  var pageNumber = 1;

  BoredBLoC() {
    _indexController.stream.listen(_handleIndex);
    _resultController.addError(
            (error) => print("_boredResultController error->${error.toString()}"));
    _indexController.addError(
            (error) => print("_boredIndexController error->${error.toString()}"));
  }

  void _handleIndex(bool isLoadMore) async {
    print("ready to get request");
    if (isLoadMore) {
      pageNumber++;
    } else {
      pageNumber = 1;
    }


    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_pic_comments&page=$pageNumber";
    try {
      Response<Map<String, dynamic>> response = await Dio().get(dataUrl);
      print("bored image request result${response}");
      if (response.statusCode == 200) {

        var boredModel = BoredImageModel.fromJson(response.data);
        if(isLoadMore){
          datas.addAll(boredModel.comments);
        }else{
          datas = boredModel.comments;
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
  void dispose() {
  }

}