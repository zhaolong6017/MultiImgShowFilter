import 'package:f_umt_app/ShareDataWidget.dart';
import 'package:flutter/material.dart';

class InheritedTestWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _InheritedTestWidgetState();
}

class _InheritedTestWidgetState extends State<InheritedTestWidget>{

  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(BaseInheritedWidget.of(context)!.data.toString(),style: TextStyle(color: Colors.white),);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("共享数据发生变化");
  }

}