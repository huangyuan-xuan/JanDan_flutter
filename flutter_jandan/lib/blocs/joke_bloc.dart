import 'bloc_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_jandan/bean/joke_bean.dart';

class JokeBLoC extends BLoCBase{

  StreamController<List<JokeBean>> _resultController = StreamController.broadcast();
  Sink<List<JokeBean>> get inResult=> _resultController.sink;
  Stream<List<JokeBean>> get outResult => _resultController.stream;


  Stream<List<JokeBean>> get outResultList => _resultController.stream;

  StreamController<bool> _indexController = StreamController<bool>.broadcast();

  Sink<bool> get inJokesIndex => _indexController.sink;

  List<JokeBean> datas = [];
  var pageNumber = 1;

  NewsBLoC() {
    _indexController.stream.listen(_handleIndex);
    _resultController.addError(
            (error) => print("_jokeResultController error->${error.toString()}"));
    _indexController.addError(
            (error) => print("_jokeIndexController error->${error.toString()}"));
  }


  void _handleIndex(bool isLoadMore) async {
    if (isLoadMore) {
      pageNumber++;
    } else {
      pageNumber = 1;
    }

    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=$pageNumber";
    try {
      Response<Map<String, dynamic>> response = await Dio().get(dataUrl);
      if (response.statusCode == 200) {
        var jokeModel = JokeModel.fromJson(response.data);
          if(isLoadMore){
            datas.addAll(jokeModel.comments);
          }else{
            datas = jokeModel.comments;
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