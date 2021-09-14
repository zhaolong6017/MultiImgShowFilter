


import 'package:flutter/material.dart';

class ScalingWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateScalingWidget();
  }
  
}

class StateScalingWidget extends State<ScalingWidget> with TickerProviderStateMixin{

   final TransformationController _transformationController = TransformationController();

   Animation<Matrix4>? _animationReset;
   late final AnimationController _controllerReset;

  
   void _onAnimateReset() {
     _transformationController.value = _animationReset!.value;
     if (!_controllerReset.isAnimating) {
       _animationReset!.removeListener(_onAnimateReset);
       _animationReset = null;
       _controllerReset.reset();
     }
   }
  
   void _animateResetInitialize() {
     _controllerReset.reset();
     _animationReset = Matrix4Tween(
       begin: _transformationController.value,
       end: Matrix4.identity(),
     ).animate(_controllerReset);

     _animationReset!.addListener(_onAnimateReset);
     _controllerReset.forward();
   }
  
   // Stop a running reset to home transform animation.
   void _animateResetStop() {
     _controllerReset.stop();
     _animationReset?.removeListener(_onAnimateReset);
     _animationReset = null;
     _controllerReset.reset();
   }
  
   void _onInteractionStart(ScaleStartDetails details) {
     // If the user tries to cause a transformation while the reset animation is
     // running, cancel the reset animation.
     if (_controllerReset.status == AnimationStatus.forward) {
       _animateResetStop();
     }
   }
  
   @override
   void initState() {
     super.initState();
     _controllerReset = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 400),
     );
   }
  
   @override
   void dispose() {
     _controllerReset.dispose();
     super.dispose();
   }
  
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.primary,
       appBar: AppBar(
         automaticallyImplyLeading: false,
         title: const Text('Controller demo'),
       ),
       body: Center(
         child: InteractiveViewer(
           boundaryMargin: const EdgeInsets.all(double.infinity),
           transformationController: _transformationController,
           minScale: 0.1,
           maxScale: 1.0,
           onInteractionStart: _onInteractionStart,
           child: Container(
             decoration: const BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: <Color>[Colors.orange, Colors.red],
                 stops: <double>[0.0, 1.0],
               ),
             ),
           ),
         ),
       ),
       persistentFooterButtons: <Widget>[
         IconButton(
           onPressed: _animateResetInitialize,
           tooltip: 'Reset',
           color: Theme.of(context).colorScheme.surface,
           icon: const Icon(Icons.replay),
         ),
       ],
     );
   }
}