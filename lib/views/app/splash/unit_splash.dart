// import 'dart:io';
// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myUnit/app/router.dart'; //路由
import 'unit_paint.dart'; //canvas绘制app进入图案

/// 说明: app 闪屏页 动画进入

class UnitSplash extends StatefulWidget {
  final double size;

  UnitSplash({this.size = 200});

  @override
  _UnitSplashState createState() => _UnitSplashState();
}

class _UnitSplashState extends State<UnitSplash> with TickerProviderStateMixin {
  AnimationController _controller; //动画控制器
  double _factor;                  //动画量取值
  Animation _curveAnim;            //动画运动类型

  bool _animEnd = false;           //动画是否停止

  @override
  void initState() {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    //vsync对象：绑定动画的定时器到一个可视的widget，需要混入 TickerProviderStateMixin
    //vsync作用：当widget不显示时，动画定时器将会暂停，当widget再次显示时，动画定时器重新恢复执行 减少资源销毁
    _controller = AnimationController(duration: Duration(milliseconds: 3000), vsync: this)
                  ..addListener(_listenAnimation)    //动画过程侦听器
                  ..addStatusListener(_listenStatus) //添加动画状态侦听器
                  ..forward();                       //正向动画 / reverse反选动画
    
    //parent：注入 _controller 动画控制器，通过addListener监听可以得出动画运动量, curve动画类型：曲线动画
    _curveAnim = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn); 
    super.initState();
  }

  void _listenAnimation() {
    setState(() {
      //将每时每刻的动画量赋值给 _factor
      return _factor = _curveAnim.value;
    });
  }

  void _listenStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) { //当运动状态完成时
      setState(() {
        _animEnd = true; //动画执行完毕
        //跳转动画500ms
        Future.delayed(Duration(milliseconds: 500)).then((e) {
          //动画效果执行完毕路由跳转到nav部件页面
          Navigator.of(context).pushReplacementNamed(Router.nav);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var winH = MediaQuery.of(context).size.height; //获取屏幕高度
    var winW = MediaQuery.of(context).size.width;  //获取屏幕宽带

    return Scaffold( //脚手架
      body: Stack(   //层叠布局：允许子组件堆叠
        alignment: Alignment.center, //水平居中
        children: <Widget>[
          _buildLogo(Colors.blue),   //顶部 "flutter" logo动画
          Container(
            width: winW,
            height: winH,
            child: CustomPaint(      //使用 Canvas 和 Paint 来进行绘制
              //painter背景画笔，绘制内容会显示在child子节点后面
              painter: UnitPainter(factor: _factor), //canvas绘制4块颜色块运动
            ),
          ),
          _buildText(winH, winW),  //"Flutter Unit"字样的渐变效果
          _buildHead(),            //作者头像运动动画
          _buildPower(),           //右下角 "Power By 张风捷特烈"
        ],
      ),
    );
  }

  Widget _buildText(double winH, double winW) {
    final shadowStyle = TextStyle( //文字的字体样式
      fontSize: 25,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      shadows: [
        const Shadow(
          color: Colors.grey,
          offset: Offset(1.0, 1.0),
          blurRadius: 1.0,
        )
      ],
    );

    return Positioned( //决定定位
      top: winH / 1.4, //距离顶部
      child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _animEnd ? 1.0 : 0.0, //动画执行完毕："Flutter Unit"不透明度 = 1
          child: Text(
            'Flutter Unit',
            style: shadowStyle, //设置字体样式
          )),
    );
  }

  final colors = [Colors.red, Colors.yellow, Colors.blue];

  Widget _buildLogo(Color primaryColor) { //顶部 "flutter" logo动画
    return SlideTransition(               //平移动画过渡
      position: Tween<Offset>(            //绝对定位设置位置动画
        begin: const Offset(0, 0),        //初始位置：(x, y) x:屏幕向右，y:屏幕向下
        end: const Offset(0, -1.5),       //结束位置：向上平移1.5倍的高度
      ).animate(_controller),
      child: RotationTransition(          //RotationTransition控制子元素旋转pai的动画
          turns: _controller,             //角度 = _controller * 2π
          child: ScaleTransition(         //ScaleTransition 动画过渡类
            //begin：初始2倍大小，end：结束1倍大小
            scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
            child: FadeTransition(
                opacity: _controller,     //不透明度
                child: Container(
                  height: 120,
                  child: FlutterLogo(     //Flutter Logo图像
                    colors: primaryColor,
                    size: 60,
                  ),
                )),
          )),
    );
  }

  Widget _buildHead() => SlideTransition(
      position: Tween<Offset>(             //绝对定位设置位置动画
        end: const Offset(0, 0),           //初始位置：(x, y) x:屏幕向右，y:屏幕向下
        begin: const Offset(0, -5),        //结束位置：向上平移5倍的高度
      ).animate(_controller),
      child: Container(
        height: 45,
        width: 45,
        child: Image.asset('assets/images/icon_head.png'), //作者头像
      ));

  Widget _buildPower() => Positioned( //部件绝对定位
        bottom: 30,                   //距离底部30
        right: 30,                    //距离右边30
        child: AnimatedOpacity(       //隐式动画 opacity 改变触发动画
            duration: const Duration(milliseconds: 300),
            opacity: _animEnd ? 1.0 : 0.0, //动画结束后完全显示右下角 "注释版"
            child: const Text("注释版",
                style: TextStyle(          //字体样式
                    color: Colors.grey,
                    shadows: [
                      Shadow(              //阴影
                          color: Colors.black,
                          blurRadius: 1,
                          offset: Offset(0.3, 0.3))
                    ],
                    fontSize: 16))),
      );
}
