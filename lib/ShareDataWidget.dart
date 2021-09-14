import 'package:flutter/material.dart';

class BaseInheritedWidget extends InheritedWidget {

  final int data;//需要在子树中共享的数据，保存点击次数

  BaseInheritedWidget({
    required this.data,
    Widget? child,
  }) : super(child: child!);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static BaseInheritedWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<BaseInheritedWidget>();
    // return context.getElementForInheritedWidgetOfExactType<BaseInheritedWidget>()!.widget;
  }

  @override
  bool updateShouldNotify(covariant BaseInheritedWidget oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    bool status = oldWidget.data != data;
    print(status);
    return status;
  }
}
