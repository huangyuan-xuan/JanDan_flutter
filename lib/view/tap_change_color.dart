import 'package:flutter/material.dart';

class TapChangeColorText extends StatefulWidget {
  TapChangeColorText({Key key, this.text}) : super(key: key);

  final String text;

  @override
  State<StatefulWidget> createState() {
    return TapChangeColorTextState();
  }
}
class TapChangeColorTextState extends State<TapChangeColorText>
    with TickerProviderStateMixin {
  bool isClicked = false;
  toggleState() {
    setState(() {
      if (!isClicked) {
        animationController.forward();
        isClicked = true;
      }
    });
  }
  Animation<double> animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = new Tween(begin: 1.0, end: 0.9).animate(animationController)
      ..addStatusListener((state) {
        if (AnimationStatus.completed == state) {
          animationController.reverse();
        }
      })
      ..addListener(() {
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleState,
      child: Text(
        widget.text,
        style: TextStyle(
            color: isClicked ? Colors.red : Colors.black,
            fontSize: 14 * animation.value),
      ),
    );
  }
}
