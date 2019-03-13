# 煎蛋flutter

####  常用控件
* TabBar
* Card
* Container
* Text
* Column
* Offstage
* FadeInImage
* Row
* Icon
* RefreshIndicator

#### json解析及序列化
##### 网络请求:'dart:io';
``` dart
    var httpClient = new HttpClient();
    String dataUrl =
        "https://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_ooxx_comments&page=$pageNumber";
    var request = await httpClient.getUrl(Uri.parse(dataUrl));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      var girlsImageModel = GirlsImageModel.fromJson(json.decode(jsonStr));
    }
```
* JSON解析:'dart:convert';
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

基类
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
  factory BaseResultBean.fromJson(Map<String, dynamic> json) => _$BaseResultBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResultBeanToJson(this);

}
```
因为这里面没有办法使用泛型，只能使用继承和组合的方式来写了.
写完之后会报错，别慌，根目录下执行
`flutter packages pub run build_runner build`，这条命令每次改变实体类的时候都需要执行，可以换成
`flutter packages pub run build_runner watch`


#### 混编
#####  创建flutter module
命令行执行 `flutter create -t module flutter_module`或者直接使用AS创建。
路径可以和你的工程平级，也可以是工程的子级。
##### 修改工程的 setting.gradle
添加如下代码
``` groovy
setBinding(new Binding([gradle: this]))                       
evaluate(new File( 
        settingsDir.parentFile,
        'flutter_check/.android/include_flutter.groovy'
))
```
如果flutter module和工程平级，则是上面的代码。
如果flutter module是工程的子目录，则`settingsDir.parentFile,`改为`settingsDir,`
##### 主工程依赖
``` groovy
dependencies {
    ...
    implementation(project(':flutter'),{
        exclude group: 'com.android.support'
    })
    ...
```
如果有support包冲突，则exclude排除一下
##### Android中加载flutter界面
找个Activity，在onCreate中
``` java
FlutterView flutterView = Flutter.createView(this, getLifecycle(), "main");
setContentView(flutterView);
```
在flutter module中`main.dart`中添加
``` dart
import 'dart:ui';
void main() {
  runApp(_widgetForRoute(window.defaultRouteName));
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'main':
    case '/':
      return App();
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}
```
这里注意的是，case中的`main`要和Activity中创建FlutterView参数一致。


##### 互相调用
通过 `MethodChannel`互相调用
在Activity中初始化一个`MethodChannel`
``` java
private void initChannel(FlutterView flutterView) {
        mChannel = new MethodChannel(flutterView, "my_flutter/plugin");

        mChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                switch (methodCall.method) {
                    case "to_license":
                        startActivity(new Intent(MainActivity.this,LicenseActivity.class));
                        result.success(true);
                        break;
                    case "to_webview":
                        String url = methodCall.arguments.toString();

                        Uri uri = Uri.parse(url);
                        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                        if (intent.resolveActivity(getPackageManager()) != null) {
                            // 网址正确 跳转成功
                            startActivity(intent);
                            result.success(true);
                        } else {
                            result.success(false);
                        }
                        result.success("jump");
                        break;
                    default:
                        break;
                }
            }
        });
```
注意channel的名字，这里设置一个`MethodChannel.MethodCallHandler`,在回调函数中可以通过`methodCall.method`拿到flutter调用的方法名字。result则是回调flutter，这个方法执行的结果。
在flutter中
``` dart
//初始化一个channel，名字和Android中一致
MethodChannel channel = const MethodChannel('my_flutter/plugin');
//在某个控件的点击事件上调用Android
onTap: () async {
    try {
        await channel.invokeMethod('to_webview',"https://blog.huangyuanlove.com");
        // 将 dynamic 类型转换成需要的类型（与平台端返回值给定的类型要一致）
    } on PlatformException catch (e) {
        print(e.message);
    }
},
```
反之，Android调用flutter也是一样的。Android中调用
`mChannel.invokeMethod("methodName","params");`
在flutter中
`channel.setMethodCallHandler(methodHandler);`