import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
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
                    title: ClickableText(
                      content: "https://blog.huangyuanlove.com",
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_link),
                    title: ClickableText(
                      content: "https://github.com/huangyuanlove",
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: ClickableText(
                        content:
                            "https://huangyuan.gitbook.io/learning-record"),
                  )
                ],
              ))
            ],
          )),
    );
  }
}

class ClickableText extends StatefulWidget {
  ClickableText({Key key, this.content}) : super(key: key);

  final String content;

  @override
  _ClickableTextState createState() {
    return new _ClickableTextState();
  }
}

class _ClickableTextState
    extends State<ClickableText> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
          text: widget.content,
          style: TextStyle(
            color: Colors.blue,
          ),
          recognizer: _tapGestureRecognizer
            ..onTap = () {
            _launchURL(widget.content);
            },
        ),
      ])),
    );
  }
}
