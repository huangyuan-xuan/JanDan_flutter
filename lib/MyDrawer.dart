import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

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
                    title: Text(
                      "https://blog.huangyuanlove.com",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_link),
                    title: Text(
                      "https://github.com/huangyuanlove",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(
                      "https://huangyuan.gitbook.io/learning-record",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
