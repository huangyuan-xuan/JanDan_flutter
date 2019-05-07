import 'dart:async';

void main() {
  // 初始化一个单订阅的Stream controller
  final StreamController ctrl = StreamController.broadcast();

  // 初始化一个监听
  final StreamSubscription subscription = ctrl.stream.listen((data) => print('$data'));

  // 往Stream中添加数据
  ctrl.sink.add('my name');
  ctrl.sink.add(1234);
  ctrl.sink.add({'a': 'element A', 'b': 'element B'});
  ctrl.sink.add(123.45);

  // StreamController用完后需要释放
  ctrl.close();
}