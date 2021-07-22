import 'package:flutter/material.dart';

class drawHome extends StatefulWidget {
  const drawHome({Key key}) : super(key: key);

  @override
  _drawHomeState createState() => _drawHomeState();
}

class _drawHomeState extends State<drawHome> {
  // 当前缩放值
  double _scale = 2.0;
  double _previousScale;
// 当前偏移值
  Offset _offset = Offset.zero;

  var yOffset = 400.0;
  var xOffset = 50.0;
  var rotation = 0.0;
  var lastRotation = 0.0;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RawKeyboardListener(
      onKey: (RawKeyEvent event) {
        print(event.data.logicalKey);
      },
      autofocus: true,
      focusNode: focusNode,
      child: Listener(
          onPointerSignal: (pointerSignal) {
            print(pointerSignal);
          },
          child: Transform(
              transform: Matrix4.identity()
                ..translate(_offset.dx, _offset.dy)
                ..scale(_scale, _scale),
              child: GestureDetector(
                onTap: () {
                  print('tap');
                },
                onSecondaryTap: () {
                  print('onSecondaryTap');
                },
                onScaleStart: (scaleDetails) {
                  _previousScale = _scale;
                  print(' scaleStarts = ${scaleDetails.focalPoint}');
                },
                onScaleUpdate: (scaleUpdates) {
                  //ScaleUpdateDetails
                  rotation += lastRotation - scaleUpdates.rotation;
                  lastRotation = scaleUpdates.rotation;
                  print("lastRotation = $lastRotation");
                  print(
                      ' scaleUpdates = ${scaleUpdates.scale} rotation = ${scaleUpdates.rotation}');
                  setState(() => _scale = _scale * 1.1);
                },
                onScaleEnd: (scaleEndDetails) {
                  _previousScale = null;
                  print(' scaleEnds = ${scaleEndDetails.velocity}');
                },
                child: Container(
                  child: Text('data'),
                ),
              ))),
    ));
  }
}
