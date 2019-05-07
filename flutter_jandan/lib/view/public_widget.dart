import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'full_image_with_download.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

//查看大图
viewPic(BuildContext context,String imageUri) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context) {
        return new ViewImage(imageUri);
      }));
}


//展示图片的item
Widget buildMultiImageWidget(BuildContext context, List<String> imageUrls){
  if(imageUrls.length == 1){
   return buildImageWidget(context,imageUrls[0]);

  }else {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisSpacing: 10.0,
        mainAxisSpacing:10.0,
      crossAxisCount: 3,
      children: buildImageListWidget(context,imageUrls)
    );
  }
}

List<Widget> buildImageListWidget(BuildContext context,List<String> imageUrls){
  List<Widget> imageWidgets =[];
  for(int i = 0 ; i < imageUrls.length;i++){
    imageWidgets.add(buildImageWidget(context,imageUrls[i]));
  }

//  imageUrls.map((imageUrl)=>imageWidgets.add(buildImageWidget(context,imageUrl)));
  return imageWidgets;

}

Widget buildImageWidget(BuildContext context, String image){
  return GestureDetector(
    child: new CachedNetworkImage(
      placeholder: (context, url) => SpinKitPumpingHeart(color: Colors.redAccent),
      errorWidget: (context, url, error) => new Icon(Icons.error),
      imageUrl:image,
    ),
    onTap: () => viewPic(context,image),
  );
}