import 'package:flutter/material.dart';
import 'dart:math';

class select_rect extends StatelessWidget {
  final Size size;
  final double dx;
  final double dy;

  select_rect({@required this.size, @required this.dx, @required this.dy});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: MyPainter(dx, dy), //在Painter中写真正的绘画逻辑
    );
  }
}

class MyPainter extends CustomPainter {
  final double x;
  final double y;
  Paint mPaint; //主画笔
  Paint bgPaint; //背景画笔

  MyPainter(this.x, this.y);
  void _drawRect(Canvas canvas) {
    mPaint = new Paint();
    mPaint.style = PaintingStyle.stroke;
    bgPaint = new Paint()..color = Color.fromARGB(148, 198, 246, 248);
    Rect rect = Rect.fromLTRB(0, 0, x, y);
    canvas.drawRect(rect, mPaint);
    canvas.save();
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(x);
    print(y);
    _drawRect(canvas);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    if ((oldDelegate.x - x).abs() > 2 || (oldDelegate.y - y).abs() > 2) {
      return true;
    } else {
      return false;
    }
  }
}
