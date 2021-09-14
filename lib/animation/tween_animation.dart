

import 'package:f_umt_app/animation/AnimatedLogo.dart';
import 'package:flutter/material.dart';

class TweenAnimationWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TweenAnimationWidgetState();
  }

}

class TweenAnimationWidgetState extends State<TweenAnimationWidget> with SingleTickerProviderStateMixin{

  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //..  dart级联符号，，使用左侧的返回值来调用，返回值的方法

    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller!)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value




        });
      });

    controller!.forward();

  }


  @override
  Widget build(BuildContext context) {

    return new Center(

      // child: new Container(
      //
      //   margin: new EdgeInsets.symmetric(vertical: 10.0),
      //
      //   height: animation!.value,
      //   width: animation!.value,
      //
      //
      //   child: new FlutterLogo(),
      // ),
      child: AnimatedLogo(animation: animation,),
    );

  }


  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();




  }
























}