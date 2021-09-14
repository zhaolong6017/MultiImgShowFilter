
import 'package:f_umt_app/InheritedTestWidget.dart';
import 'package:f_umt_app/ShareDataWidget.dart';
import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InheritedWidgetTestRouteState();
  }

}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute>{

  int count = 0;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: BaseInheritedWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Padding(padding: EdgeInsets.only(top: 20.0)),

            RaisedButton(onPressed: () => setState( () =>  {
              ++ count,
              print("当前计数 $count")
            }),child: Text("Increment"),),

            InheritedTestWidget(),

          ],

        ),
      ),


    );
  }

}