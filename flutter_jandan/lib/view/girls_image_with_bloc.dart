import 'package:flutter/material.dart';
import 'package:flutter_jandan/blocs/girls_image_bloc.dart';
import 'package:flutter_jandan/blocs/bloc_provider.dart';
import 'package:flutter_jandan/bean/girls_image_bean.dart';
import 'tap_change_color.dart';
import 'package:flutter_jandan/view/public_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class GirlsImageWithBLoC extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    GirlsImageBLoC girlsImageWithbloc  = BLoCProvider.of<GirlsImageBLoC>(context);
    ScrollController _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        girlsImageWithbloc.inGirlsIndex.add(true);
      }
    });
    girlsImageWithbloc.inGirlsIndex.add(false);

    return StreamBuilder<List<GirlsImageBean>>(
      stream: girlsImageWithbloc.outGirlsList,
        builder: (BuildContext context,
        AsyncSnapshot<List<GirlsImageBean>> snapshot) {
        if(snapshot.data == null){
          return SpinKitWave(color: Colors.white, type: SpinKitWaveType.start);
        }


        return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data ==null?1:snapshot.data.length + 1,
            itemBuilder: (BuildContext context, int position) {
              return _getRow(context,snapshot.data, position);
            });
        }
    );
  }
  Widget _getRow(BuildContext context,List<GirlsImageBean> widgets, int i) {

    if(widgets==null){
      return  null;
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
                data.authorName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data.date,
                style: TextStyle(fontSize: 12),
              ),
              Offstage(
                offstage: data.textContent == null ||
                    data.textContent.trim().length == 0,
                child: Text(
                  data.textContent.trim(),
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.2),
                ),
              ),
              buildMultiImageWidget(context,data.pics),

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