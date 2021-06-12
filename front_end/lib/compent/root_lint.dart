import 'package:flutter/material.dart';
import 'dart:math';

// 将饼图封装成一个新的控件
class RootLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // 设置控件宽高
      size: Size(10, 2),
      painter: LinePaint(),
    );
  }
}

// 自绘控件
class LinePaint extends CustomPainter {
  // 绘制逻辑
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    // 设置画笔颜色
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    Offset p1 = Offset(-4, 0);
    Offset p2 = Offset(10, 0);
    canvas.drawLine(p1, p2, paint);
  }

  // 判断是否需要重绘，这里简单的做下比较即可
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
