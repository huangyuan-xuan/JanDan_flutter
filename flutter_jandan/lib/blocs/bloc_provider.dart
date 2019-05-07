import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
abstract class BLoCBase {
  void dispose();

  void showError() {
    Fluttertoast.showToast(
        msg: "请求失败",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black12);
  }
}

class BLoCProvider<T extends BLoCBase> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BLoCProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  @override
  _BLoCProviderState<T> createState() => _BLoCProviderState<T>();

  static T of<T extends BLoCBase>(BuildContext context){
    final type =  _typeOf<BLoCProvider<T>>();
    BLoCProvider provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>()=>T;

}

class _BLoCProviderState<T> extends State<BLoCProvider<BLoCBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    print("BLoCProvider dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print("BLoCProvider build-->${widget.child.hashCode}");
    return widget.child;
  }



}
