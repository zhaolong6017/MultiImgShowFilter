import 'package:f_umt_app/color_widget/ImageFilter.dart';
import 'package:flutter/material.dart';

///图片处理界面
///扫描功能，针对原始图片 黑白反转、 对比度、亮度调节、放大缩小功能预研
class PhotoTransUtilWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PhotoTransUtilWidgetState();
  }

}

class PhotoTransUtilWidgetState extends State<PhotoTransUtilWidget> with TickerProviderStateMixin {

  TransformationController _transformationController = TransformationController(); //可动态添加，缩放InteractiveViewer组件的控制器

  double _sliderValue = 0.0;
  int sliderType = 0;

  bool _sliderIsShow = true;
  String _sliderNotice = "";


  double minSliderValue = 0;
  double maxSliderValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "图片处理界面",
          style: TextStyle(color: Colors.red, fontSize: 20.0),
        ),
      ),
      body: ConstrainedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  child: Text("对比度"),
                  onPressed: () {
                    setState(() {
                      _sliderNotice = "请动态改变对比度：";
                      _sliderIsShow = false;

                      _sliderValue = 0;
                      sliderType = 0;
                      minSliderValue = 0;
                      maxSliderValue = 1;
                    });
                  },
                ),
                FlatButton(
                  child: Text("亮度"),
                  onPressed: () {
                    setState(() {
                      _sliderNotice = "请动态改变亮度：";
                      _sliderIsShow = false;

                      _sliderValue = 0;
                      sliderType = 1;
                      minSliderValue = 0;
                      maxSliderValue = 1;
                    });
                  },
                ),
                OutlineButton(
                  child: Text("放大，缩小"),
                  onPressed: () {
                    setState(() {
                      _sliderNotice = "请动态改变图片大小：";
                      _sliderIsShow = false;

                      _sliderValue = 1.0; //缩放倍数默认为1.0
                      sliderType = 2;
                      minSliderValue = 0.5;
                      maxSliderValue = 2.5;
                    });
                  },
                ),
                TextButton(
                  child: Text("黑白反转"),
                  onPressed: () {
                    setState(() {
                      _sliderIsShow = false;
                      _sliderNotice = "点击图片反转：";

                      _sliderValue = 0.75;
                      sliderType = 3;
                      minSliderValue = 0.75;
                      maxSliderValue = 1;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                scaleEnabled: true,
                maxScale: 5,
                minScale: 0.3,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      ImageFilter(
                        hue: sliderType == 3 && _sliderValue!=0.75 ? _sliderValue : 0,
                        brightness: sliderType == 1 ? _sliderValue : 0,
                        contrast: sliderType == 0 ? _sliderValue : 0,
                        child: Image(
                          image: AssetImage("images/person.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        width: 60.0,
                        height: 60.0,
                        top: 20.0,
                        right: 50.0,
                        child: ImageFilter(
                          hue: sliderType == 3 && _sliderValue!=0.75 ? _sliderValue : 0,
                          brightness: sliderType == 1 ? _sliderValue : 0,
                          contrast: sliderType == 0 ? _sliderValue : 0,
                          child: Image(
                            image: AssetImage("images/icon1.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          width: 60.0,
                          height: 60.0,
                          bottom: 0,
                          left: 20.0,
                          child: ImageFilter(
                            hue: sliderType == 3 && _sliderValue!=0.75 ? _sliderValue : 0,
                            brightness: sliderType == 1 ? _sliderValue : 0,
                            contrast: sliderType == 0 ? _sliderValue : 0,
                            child: Image(
                              image: AssetImage("images/icon2.jpg"),
                              fit: BoxFit.fill,
                            ),
                          )),
                    ],
                  ),
                ),
                transformationController: _transformationController,
              ),
            ),

            //slider bar
            Offstage(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    _sliderNotice,
                    style: TextStyle(color: Colors.red, fontSize: 25.0),
                  ),
                  Slider(
                    value: _sliderValue,
                    onChanged: (value) {
                      setState(() {
                        print("当前选中的值$value");
                        _sliderValue = value;
                      });
                      _scaleImage();
                    },
                    min: minSliderValue,
                    max: maxSliderValue,
                  ),
                ],
              ),
              offstage: _sliderIsShow,
            )
          ],
        ),
        constraints: BoxConstraints(minWidth: double.infinity),
      ),
    );
  }

  _scaleImage() async {
    //在现有的基础上进行缩放
    if (sliderType == 2) {
      var matrix = Matrix4.identity();
      matrix.scale(_sliderValue);
      _transformationController.value = matrix;
    }
  }
}
