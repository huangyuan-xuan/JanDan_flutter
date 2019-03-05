import 'package:flutter/material.dart';

// 加载更多时显示的组件
Widget getOnLoadMoreWidget() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '加载中...     ',
            style: TextStyle(fontSize: 16.0),
          ),
          CircularProgressIndicator(
            strokeWidth: 1.0,
          )
        ],
      ),
    ),
  );
}