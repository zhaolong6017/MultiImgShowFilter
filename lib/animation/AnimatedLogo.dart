

import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget{

  AnimatedLogo({Key? key,Animation<double>? animation}) : super(key:key,listenable: animation!);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;

    return new Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: animation.value,
        height: animation.value,

        child: new FlutterLogo(),

      ),


    );

  }




}