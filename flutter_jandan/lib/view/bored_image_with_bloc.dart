import 'package:flutter/material.dart';
import 'package:flutter_jandan/blocs/bored_bloc.dart';
import 'package:flutter_jandan/blocs/bloc_provider.dart';
import 'package:flutter_jandan/bean/bored_image_bean.dart';
import 'tap_change_color.dart';
import 'package:flutter_jandan/view/public_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BoredImageWithBLoC extends StatelessWidget {
  BoredBLoC boredBLoC;
  @override
  Widget build(BuildContext context) {
     boredBLoC = BLoCProvider.of<BoredBLoC>(context);

    ScrollController _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        boredBLoC.inBoredIndex.add(true);
      }
    });

    boredBLoC.inBoredIndex.add(false);

    return RefreshIndicator(
      onRefresh: ()=>refresh(),
      child:StreamBuilder<List<BoredImageBean>>(
          stream: boredBLoC.outResult,
          builder: (BuildContext context,
              AsyncSnapshot<List<BoredImageBean>> snapshot) {
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
          }) ,
    );
  }

  Future<void> refresh() async{
    boredBLoC.inBoredIndex.add(false);

  }


  Widget _getRow(BuildContext context, List<BoredImageBean> widgets, int i) {
    if (widgets == null) {
      return null;
    }

    if (i < widgets.length) {
      var data = widgets[i];
      return Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${data.author}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${data.date}",
                style: TextStyle(fontSize: 12),
              ),
              Offstage(
                offstage: data.content == null ||
                    data.content.toString().trim().length == 0,
                child: Text(
                  "${data.content.toString().trim()}",
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.2),
                ),
              ),
              buildMultiImageWidget(context, data.pics),
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
