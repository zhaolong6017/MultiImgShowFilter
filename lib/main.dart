import 'package:f_umt_app/InheritedTestWidget.dart';
import 'package:f_umt_app/animation/animation_test.dart';
import 'package:f_umt_app/photo_trans.dart';
import 'package:f_umt_app/routes/BWidget.dart';
import 'package:f_umt_app/scalingWidget.dart';
import 'package:flutter/material.dart';

import 'InheritedWidgetTestRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        "B_Widget": (_) => BWidget(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AnimationTestWidget(
                  userName: "zhaolong",
                  passWord: "zhaolong123",
                ))).then((value) => {print("上个界面回调$value")});

    // Navigator.pushNamed(context, "B_Widget");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InheritedWidgetTestRoute()));
              },
              icon: Icon(Icons.lock),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Hello World",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.5,
                fontFamily: "Courier",
                background: new Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            RichText(
              text: TextSpan(children: [
                WidgetSpan(child: Icon(Icons.add)),
                TextSpan(
                    text: "zhaolong", style: TextStyle(color: Colors.yellow)),
                WidgetSpan(child: Icon(Icons.delete)),
              ]),
            ),
            DefaultTextStyle(
              style: TextStyle(color: Colors.red, fontSize: 20.0),
              child: Column(
                children: [
                  Text("hello world"),
                  Text("I am Jack"),
                  Text(
                    "I am Jack",
                    style: TextStyle(
                        inherit: false, //2.不继承默认样式
                        color: Colors.grey),
                  ),
                ],
              ),
            ),



            ///图片处理入口
            TextButton(
              child: Text(
                "点击跳转到图片处理界面",
                style: TextStyle(color: Colors.blue, fontSize: 30.0),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhotoTransUtilWidget()));
                    // MaterialPageRoute(builder: (context) => ScalingWidget()));
              },
            )




          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
