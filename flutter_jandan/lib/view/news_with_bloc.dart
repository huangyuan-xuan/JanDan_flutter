import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_jandan/blocs/news_bloc.dart';
import 'package:flutter_jandan/blocs/bloc_provider.dart';
import 'package:flutter_jandan/bean/news_bean.dart';
import 'package:flutter_jandan/view/public_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsWithBLoC extends StatelessWidget {
  NewsBLoC newsBLoC ;
  @override
  Widget build(BuildContext context) {
    newsBLoC = BLoCProvider.of<NewsBLoC>(context);
    ScrollController _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        newsBLoC.inNewsIndex.add(true);
      }
    });
    newsBLoC.inNewsIndex.add(false);

    return  RefreshIndicator(
        onRefresh: () => refresh(),
        child: StreamBuilder<List<NewsBean>>(
            stream: newsBLoC.outResultList,
            builder:
                (BuildContext context, AsyncSnapshot<List<NewsBean>> snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return SpinKitWave(
                    color: Colors.redAccent, type: SpinKitWaveType.start);
              }

              return ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      snapshot.data == null ? 1 : snapshot.data.length + 1,
                  itemBuilder: (BuildContext context, int position) {
                    return _getRow(context, snapshot.data, position);
                  });
            }));
  }


  Future<void> refresh() async{
    newsBLoC.inNewsIndex.add(false);

  }


  Widget _getRow(BuildContext context, List<NewsBean> widgets, int i) {
    if (widgets == null) {
      return null;
    }
    if (i < widgets.length) {
      var data = widgets[i];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 30,
                  padding: EdgeInsets.only(left: 8.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    data.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(data.author.nickname),
                      Text(data.date),
                      Text("${data.commentCount}评论"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: new CachedNetworkImage(
                placeholder: (context, url) => SpinKitFadingGrid(
                    color: Colors.blueGrey, shape: BoxShape.circle),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                imageUrl: data.customFields.thumb[0],
                fit: BoxFit.fill,
                height: 60,
              ),
            ),
          )
        ],
      );
    } else {
      return getOnLoadMoreWidget();
    }
  }
}
