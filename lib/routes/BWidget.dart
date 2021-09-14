
import 'package:flutter/material.dart';

class BWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BWidgetState();
  }

}

class BWidgetState extends State<BWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("BWidget"),

      ),

      body: Container(

        child: Text("静态注册路由界面，BWidget"),
      ),

    );
  }

}