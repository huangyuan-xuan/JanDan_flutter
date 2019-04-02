import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewImage extends StatelessWidget {
  final String imageUri;

  ViewImage(this.imageUri);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            new CachedNetworkImage(
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              imageUrl:imageUri,
            )
          ],
        ),
      ),
    );
  }
}
