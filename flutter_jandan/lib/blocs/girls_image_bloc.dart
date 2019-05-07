import 'bloc_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_jandan/bean/girls_image_bean.dart';

class GirlsImageBLoC extends BLoCBase {
  StreamController<List<GirlsImageBean>> _girlsController =
      StreamController.broadcast();

  Sink<List<GirlsImageBean>> get inGirlsList => _girlsController.sink;

  Stream<List<GirlsImageBean>> get outGirlsList => _girlsController.stream;

  StreamController<bool> _indexController = StreamController<bool>.broadcast();

  Sink<bool> get inGirlsIndex => _indexController.sink;

  List<GirlsImageBean> datas = [];
  var pageNumber = 1;

  GirlsImageBLoC() {
    _indexController.stream.listen(_handleIndex);
    _girlsController.addError(
        (error) => print("_girlsController error->${error.toString()}"));
    _indexController.addError(
        (error) => print("_girlsIndexController error->${error.toString()}"));
  }

  void _handleIndex(bool isLoadMore) async {
    if (isLoadMore) {
      pageNumber++;
    } else {
      pageNumber = 1;
    }

    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=$pageNumber";

    try {
      Response<Map<String, dynamic>> response = await Dio().get(dataUrl);
      if (response.statusCode == 200) {
        var girlsModel = GirlsImageModel.fromJson(response.data);
        if (isLoadMore) {
          datas.addAll(girlsModel.comments);
        } else {
          datas = girlsModel.comments;
        }
        _girlsController.add(datas);
      } else {
        showError();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
//    _girlsController.close();
//    _indexController.close();
  }
}
