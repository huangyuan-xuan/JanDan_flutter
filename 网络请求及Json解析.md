#### 发起HTTP请求

首先我们需要先导入http的支持包，然后创建httpClient。

``` dart
import 'dart:io';
var httpClient = new HttpClient();
```

HttpClient支持常见的get、post、put、delete请求。

#### 处理异步
众所周知，网络请求是耗时操作，所以我们需要进行异步操作，建议使用async/await语法来调用API。
``` dart
    var httpClient = new HttpClient(); //创建Client
    String dataUrl ="XXXXXXXX"; //构建uri
    var uri = new Uri.http(
        'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});//或者这么构建也可以
    var request = await httpClient.getUrl(Uri.parse(dataUrl));//发起请求
    var response = await request.close();//关闭连接
    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      print(jsonStr)
      
    } else {
     print("请求失败");
    }
```

#### JSON解析
采用的是官网中描述的方法
使用'dart:convert';
配合插件：

``` yaml
dependencies:
  flutter:
    sdk: flutter
  json_annotation: ^2.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^1.0.0
  json_serializable: ^2.0.0
```

由于这种解析方式不支持泛型，只能采用组合+继承的方式来实现了：

请求基类

``` dart
import 'package:json_annotation/json_annotation.dart';
part 'base_result_bean.g.dart';

@JsonSerializable()
class BaseResultBean{
  BaseResultBean();
  String status;
  @JsonKey(name: "current_page")
  int currentPage;

  @JsonKey(name: "total_comments")
  int totalComments;
  @JsonKey(name: "page_count")
  int pageCount;
  int count;
  factory BaseResultBean.fromJson(Map<String, dynamic> json) =>_$BaseResultBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResultBeanToJson(this);
}

```

写个model
``` dart
import 'package:json_annotation/json_annotation.dart';
import 'base_result_bean.dart';
part 'joke_bean.g.dart';

@JsonSerializable()
class JokeModel extends BaseResultBean{
  JokeModel();
  List<JokeBean> comments;
  factory JokeModel.fromJson(Map<String, dynamic> json) => _$JokeModelFromJson(json);
  Map<String, dynamic> toJson() => _$JokeModelToJson(this);
}

@JsonSerializable()
class JokeBean {
  JokeBean();

  @JsonKey(name: "vote_positive")
  String votePositive;

  @JsonKey(name: "vote_negative")
  String voteNegative;

  @JsonKey(name: "sub_comment_count")
  String subCommentCount;
  factory JokeBean.fromJson(Map<String, dynamic> json) => _$JokeBeanFromJson(json);
  Map<String, dynamic> toJson() => _$JokeBeanToJson(this);
}
```

写完之后会报错，别慌，根目录下执行
`flutter packages pub run build_runner build`
这条命令每次改变实体类的时候都需要执行，可以换成
`flutter packages pub run build_runner watch`

现在，我们解析json就可以这么写了

``` dart
if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      var boredImageModel = JokeModel.fromJson(json.decode(jsonStr));
}
```

如果是比较简单的json解析，可以直接通过`json.decode`进行处理，比如
``` json
{
  "name": "John Smith",
  "email": "john@example.com"
}
```
可以这么取
``` dart
Map<String, dynamic> user = json.decode(jsonStr);
print('Howdy, ${user['name']}!');
print('We sent the verification link to ${user['email']}.');
```

在flutter中文网推荐了`dio`这个库，[dio github](https://github.com/flutterchina/dio)，这里简单的使用了一下，并没有用到高级功能

`pubspec.yaml`中添加依赖`dio: ^2.1.0`,导包:`import 'package:dio/dio.dart';`

``` dart
Future<void> getHttp(bool isLoadMore) async {
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
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=$pageNumber";
    try {
      Response<Map<String, dynamic>> response = await Dio().get(dataUrl);
      if (response.statusCode == 200) {
        var jokeModel = JokeModel.fromJson(response.data);

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
```

一个简单的请求，并没有体现出`dio`的强势的地方，具体使用可以看一下`https://github.com/flutterchina/dio/blob/master/README-ZH.md`介绍。



----

以上