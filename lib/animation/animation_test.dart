
import 'package:f_umt_app/animation/tween_animation.dart';
import 'package:flutter/material.dart';


class AnimationTestWidget extends StatefulWidget{

  var userName;
  var passWord;

  AnimationTestWidget({Key? key, this.userName,this.passWord}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimationTestWidgetState();

}

class AnimationTestWidgetState extends State<AnimationTestWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){
          Navigator.of(context).pop("登录成功");
        },),
        title: Text("动画测试"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        ],
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(widget.userName),

            Text(widget.passWord),

            IconButton(
              onPressed: (){
                Navigator.of(context).pop("登录成功");
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),

            RaisedButton(onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => TweenAnimationWidget()));
              Navigator.push(context, _createRoute());


            },
              child: Text("点击跳转到动画界面"),

            )

          ],

        )

      ),

    );
  }


  Route _createRoute() {


    var begin = Offset(0.0, 1.0);
    var end = Offset(0.0, 0.0);
    var tween = Tween(begin: begin, end: end);
    // var offsetAnimation = animation.drive(tween);

    return PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) => TweenAnimationWidget(),
        transitionsBuilder:(context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset(0.0, 0.0);
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
    );

    // return PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) => TweenAnimationWidget(),
    //     transitionsBuilder:(context, animation, secondaryAnimation, child) {
    //       return child;
    //     }
    // );
  }



}