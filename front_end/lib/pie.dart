import 'package:flutter/material.dart';
import 'dart:math';

// 将饼图封装成一个新的控件
class WheelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // 设置控件宽高
      size: Size(200, 200),
      painter: WheelPaint(),
    );
  }
}

// 自绘控件
class WheelPaint extends CustomPainter {
  // 设置画笔颜色，返回不同颜色画笔
  Paint getColorPaint(Color color) {
    // 生成画笔
    Paint paint = Paint();
    // 设置画笔颜色
    paint.color = color;
    return paint;
  }

  // 绘制逻辑
  @override
  void paint(Canvas canvas, Size size) {
    // 饼图的尺寸
    double wheelSize = min(size.width, size.height) / 2;
    // 分成 6 份
    double nbElem = 6;
    // 1/6 圆
    double radius = (2 * pi) / nbElem;
    // 包裹饼图这个圆形的矩形框
    Rect boundingRect = Rect.fromCircle(
        center: Offset(wheelSize, wheelSize), radius: wheelSize);
    // 每次画 1/6 个圆弧
    canvas.drawArc(boundingRect, 0, radius, true, getColorPaint(Colors.orange));
    canvas.drawArc(
        boundingRect, radius, radius, true, getColorPaint(Colors.black38));
    canvas.drawArc(
        boundingRect, radius * 2, radius, true, getColorPaint(Colors.green));
    canvas.drawArc(
        boundingRect, radius * 3, radius, true, getColorPaint(Colors.red));
    canvas.drawArc(
        boundingRect, radius * 4, radius, true, getColorPaint(Colors.blue));
    canvas.drawArc(
        boundingRect, radius * 5, radius, true, getColorPaint(Colors.pink));
  }

  // 判断是否需要重绘，这里简单的做下比较即可
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
