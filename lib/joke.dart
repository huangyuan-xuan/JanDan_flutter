import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class Joke extends StatefulWidget {
  Joke({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _JokeState();
  }
}

class _JokeState extends State<Joke> {
  List widgets = [];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  _loadData() async {
    var httpClient = new HttpClient();
    String dataUrl =
        "http://i.jandan.net/?oxwlxojflwblxbsapi=jandan.get_duan_comments&page=1";

    var request = await httpClient.getUrl(Uri.parse(dataUrl));
    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      var jsonStr = await response.transform(utf8.decoder).join();
      setState(() {
        widgets = json.decode(jsonStr)["comments"];
      });
    }
  }

  Widget getRow(int i) {
    return new Container(
        margin: EdgeInsets.all(16.0),
        child: new Text("${widgets[i]["comment_content"]}"),
      foregroundDecoration:BoxDecoration(
            boxShadow:[
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0
              )
            ]
        ),
    );



  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new ListView.builder(
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int position) {
              return getRow(position);
            }));
  }
}
