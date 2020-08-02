import 'package:flutter/material.dart';

//canvas 绘制

class UnitPainter extends CustomPainter {
  Paint _paint;
  double width;         //绘制的正方形边长
  double factor;        //动画量取值 factor = [0, 1]
  Color color;
  Path _path1 = Path();
  Path _path2 = Path();
  Path _path3 = Path();
  Path _path4 = Path();

  UnitPainter({this.width = 100.0, this.factor,this.color=Colors.blue}) {
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    //设置canvas绘制的起点(0,0)，并保存该点作为canvas绘制参考点
    canvas.translate(size.width / 2 - width * 0.5, size.height / 2 - width * 0.5);
    canvas.save();      //保存之前画的内容与canvas的状态
    //在保存的参考点基础上再次设置canvas绘制的起点 因为最终【1 - factor = 0】,所以最终canvas.translate(0,0)
    canvas.translate(-size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    drawColor1(canvas); //左上红色小块绘制
    canvas.restore();   //将该方法与前面最近的一个save() 或saveLayer()之间的操作合并到一起

    canvas.save();
    canvas.translate(size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    drawColor2(canvas); //右上红色小块蓝色
    canvas.restore();

    canvas.save();
    canvas.translate(size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    drawColor3(canvas); //右下红色小块绿色
    canvas.restore();

    canvas.save();
    canvas.translate(-size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    drawColor4(canvas); //左下红色小块黄色
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  //左上红色小块绘制 factor = [0, 1]
  void drawColor1(Canvas canvas) {
    _path1.moveTo(0, 0); //绘制的起点
    _path1.lineTo(width * 0.618 * factor - 1, 0);       //右上角点，0.618 一条边的黄金分割点
    _path1.lineTo(width * 0.5 - 1, width * 0.5 - 1);    //右下角点，减1是因为小块间存在1单位的间隙
    _path1.lineTo(0, width * (1 - 0.618) * factor - 1); //左下角点，黄金分割线较短的那条线

    canvas.drawPath(_clipAngle(_path1), _paint..color = Colors.red); //绘制
  }
  //右上红色小块蓝色
  void drawColor2(Canvas canvas) {
    _path2.moveTo(width * 0.618 * factor, 0);
    _path2.lineTo(width, 0);
    _path2.lineTo(width, width * 0.618 * factor);
    _path2.lineTo(width * 0.5, width * 0.5);

    canvas.drawPath(_clipAngle(_path2), _paint..color = Colors.blue);
  }
  //右下红色小块绿色
  void drawColor3(Canvas canvas) {
    _path3.moveTo(width * 0.5 + 1, width * 0.5 + 1);
    _path3.lineTo(width, width * 0.618 * factor + 1);
    _path3.lineTo(width, width);
    _path3.lineTo(width * (1 - 0.618) * factor + 1, width);
    canvas.drawPath(_clipAngle(_path3), _paint..color = Colors.green);
  }
  //左下红色小块黄色
  void drawColor4(Canvas canvas) {
    _path4.moveTo(0, width * (1 - 0.618) * factor);
    _path4.lineTo(width * 0.5, width * 0.5);
    _path4.lineTo(width * (1 - 0.618) * factor, width);
    _path4.lineTo(0, width);
    canvas.drawPath(_clipAngle(_path4), _paint..color = Colors.yellow);
  }

  Path _clipAngle(Path path) {
    return Path.combine(
        PathOperation.difference,
        path,
        Path()
          ..addOval(Rect.fromCircle(
            //在(中心点)通过半径为25的圆切割小块
            center: Offset(width * 0.5, width * 0.5), radius: 25.0)
    ));
  }
}