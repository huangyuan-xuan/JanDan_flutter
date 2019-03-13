####  创建flutter module
命令行执行 `flutter create -t module flutter_module`或者直接使用AS创建。
路径可以和你的工程平级，也可以是工程的子级。只是在配置`setting.gradle`时注意一下文件夹位置就好。
#### 修改工程的 setting.gradle
添加如下代码
``` groovy
setBinding(new Binding([gradle: this]))                       
evaluate(new File( 
        settingsDir.parentFile,
        'flutter_check/.android/include_flutter.groovy'
))
```
如果flutter module和工程平级，则是上面的代码。
如果flutter modlule是工程的子目录，则`settingsDir.parentFile,`改为`settingsDir,`
#### 主工程依赖
``` groovy
dependencies {
    ...
    implementation(project(':flutter'),{
        exclude group: 'com.android.support'
    })
    ...
```
设置一下编译用的Java版本
``` groovy
compileOptions {
        sourceCompatibility 1.8
        targetCompatibility 1.8
    }
```

如果有support包冲突，则exclude排除一下
#### Android中加载flutter界面
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


#### 互相调用
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
注意channel的名字，这里设置一个`MethodChannel.MethodCallHandler`,在回调函数中可以通过`methodCall.method`拿到fluter调用的方法名字。result则是回调flutter，这个方法执行的结果。
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
混编的情况下flutter的热重载还是有效的，在flutter module的目录下执行`flutter attach`，会有提示。

----
以上