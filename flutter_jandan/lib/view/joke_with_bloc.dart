import 'package:flutter/material.dart';
import 'package:flutter_jandan/blocs/joke_bloc.dart';
import 'package:flutter_jandan/blocs/bloc_provider.dart';
import 'package:flutter_jandan/bean/joke_bean.dart';
import 'package:flutter_jandan/view/public_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'tap_change_color.dart';

class JokeWithBLoC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JokeBLoC jokeBLoC = BLoCProvider.of<JokeBLoC>(context);

    ScrollController _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        jokeBLoC.inJokesIndex.add(true);
      }
    });
    jokeBLoC.inJokesIndex.add(false);
    return StreamBuilder<List<JokeBean>>(
        stream: jokeBLoC.outResultList,
        builder:
            (BuildContext context, AsyncSnapshot<List<JokeBean>> snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return SpinKitWave(
                color: Colors.redAccent, type: SpinKitWaveType.start);
          }

          return ListView.builder(
              controller: _scrollController,
              itemCount: snapshot.data == null ? 1 : snapshot.data.length + 1,
              itemBuilder: (BuildContext context, int position) {
                return _getRow(context, snapshot.data, position);
              });
        });
  }

  Widget _getRow(BuildContext context, List<JokeBean> widgets, int i) {
    if (widgets == null) {
      return null;
    }

    if (i < widgets.length) {
      var data = widgets[i];

      return new Card(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widgets[i].author}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                child: Text(
                  "${widgets[i].date}",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.1),
                ),
              ),
              Text(
                "${widgets[i].content}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TapChangeColorText(text: "OO ${data.votePositive}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: TapChangeColorText(text: "XX ${data.voteNegative}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text("吐槽 ${data.subCommentCount}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: Icon(Icons.more_horiz),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return getOnLoadMoreWidget();
    }
  }
}
