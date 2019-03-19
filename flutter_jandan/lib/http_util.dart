import 'package:dio/dio.dart';
class HttpUtils{
  Dio dio;

  HttpUtils(){
    dio = new Dio();
    // 配置dio实例
    dio.options.baseUrl="https://i.jandan.net/";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout=3000;
  }


  Future<Response<Map<String, dynamic>>> get(String path) async {
    Response<Map<String, dynamic>> response = await Dio().get(path);
    return response;
  }



  Future<Response<Map<String, dynamic>>> request(String path) async {
    Response<Map<String, dynamic>> response = await Dio().request(path);
    return response;
  }

}