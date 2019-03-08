import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({
    Key key,
  }) : super(key: key);

  MethodChannel channel = const MethodChannel('my_flutter/plugin');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipOval(
                        child: Image.asset(
                          "images/avatar.jpeg",
                          width: 80,
                        ),
                      ),
                    ),
                    Text(
                      "xuan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.all_inclusive),
                    title: Text("博客",style: TextStyle(
                      color: Colors.blue,
                    ),),
                      onTap: () async {
                        try {

                          await channel.invokeMethod('to_webview',"https://blog.huangyuanlove.com");
                          // 将 dynamic 类型转换成需要的类型（与平台端返回值给定的类型要一致）
                        } on PlatformException catch (e) {
                          print(e.message);
                        }
                      },
//
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_link),
                    title: Text("GitHub",style: TextStyle(
                      color: Colors.blue,
                    )),
                    onTap: () async {
                      try {

                        await channel.invokeMethod('to_webview',"https://github.com/huangyuanlove");
                        // 将 dynamic 类型转换成需要的类型（与平台端返回值给定的类型要一致）
                      } on PlatformException catch (e) {
                        print(e.message);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: Text("GitBook",style: TextStyle(
                      color: Colors.blue,
                    )),
                    onTap: () async {
                      try {

                        await channel.invokeMethod('to_webview',"https://huangyuan.gitbook.io/learning-record");
                        // 将 dynamic 类型转换成需要的类型（与平台端返回值给定的类型要一致）
                      } on PlatformException catch (e) {
                        print(e.message);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.label_important),
                    title: Text("所使用的开源框架",style: TextStyle(
                      color: Colors.blue,
                    )),
                    onTap: () async {
                      try {

                        await channel.invokeMethod('to_license');
                        // 将 dynamic 类型转换成需要的类型（与平台端返回值给定的类型要一致）
                      } on PlatformException catch (e) {
                        print(e.message);
                      }
                    },
                  )
                ],
              ))
            ],
          )),
    );
  }
}
