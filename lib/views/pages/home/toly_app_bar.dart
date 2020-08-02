import 'package:flutter/material.dart';
import 'package:flutter_myUnit/app/res/cons.dart';                //主题风格
import 'package:flutter_myUnit/components/permanent/circle.dart'; //圆

//说明：

class TolyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(int, Color) onItemClick; //传递过来的点击事件
  final Size preferredSize;               //设置appBar的高度
  final int selectIndex;                  //选中颜色下标 默认0

  TolyAppBar({this.onItemClick, this.preferredSize, this.selectIndex = 0});

  @override
  _TolyAppBarState createState() => _TolyAppBarState();
}

//下部圆角边框
const _kBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);
//字体样式封装
const _kTabTextStyle = TextStyle(color: Colors.white, shadows: [
  const Shadow(color: Colors.black, offset: Offset(0.5, 0.5), blurRadius: 0.5)
]);

class _TolyAppBarState extends State<TolyAppBar>
    with SingleTickerProviderStateMixin {
  double _width = 0;                 //每个tap按钮的宽
  int _selectIndex = 0;              //当前点击的tap按钮

  List<int> colors = Cons.tabColors; //获取颜色数组
  List info = Cons.tabs;             //获取标题数组

  AnimationController _controller;   //动画控制器

  @override
  void initState() {
    //vsync对象：绑定动画的定时器到一个可视的widget，需要混入 SingleTickerProviderStateMixin
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener(_render)              //动画过程侦听器
      ..addStatusListener(_listenStatus); //添加动画状态侦听器

    _selectIndex = widget.selectIndex;    //当前点击的tap

    super.initState();

    setState(() {                         //初始动画开始 第一个按钮变长
      _controller.reset();
      _controller.forward();
    });
  }

  void _render() {                        //动画中一直刷新数据
    setState(() {});
  }

  void _listenStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) { //动画停止时刷新数据
      setState(() {});
    }
  }

  int get nextIndex => (_selectIndex + 1) % colors.length;

  @override
  Widget build(BuildContext context) {
    //获取每个tap按钮的宽
    _width = MediaQuery.of(context).size.width / colors.length;
    return Container(
      alignment: Alignment.center, //水平居中
      child: Flow(                 //Flow支持流式布局
          delegate: TolyAppBarDelegate( //绘制每个子组件
              _selectIndex, _controller.value, widget.preferredSize.height),
          children: [
            ...colors
                .map((e) => GestureDetector(
                    onTap: () => _onTap(e),
                    child: _buildChild(e))).toList(),
            ...colors.map((e) => Circle( //圆形组件 绘制下面的圆
                  color: Color(e),
                  radius: 6,
                ))
          ]),
    );
  }
  //生成tap按钮
  Widget _buildChild(int color) => Container(
    alignment: const Alignment(0, 0.4),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow( //阴影
          color: _selectIndex == colors.indexOf(color)
              ? Colors.transparent
              : Color(colors[_selectIndex]),
          offset: Offset(1, 1),
          blurRadius: 2)
    ],
    color: Color(color), borderRadius: _kBorderRadius),
    height: widget.preferredSize.height + 20, //tap按钮高度
    width: _width,
    child: Text( //内部标题文字
      info[colors.indexOf(color)],
      style: _kTabTextStyle,
    ),
  );
  
  //点击tap触发方法
  _onTap(int color) {
    setState(() {
      _controller.reset();
      _controller.forward();
      _selectIndex = colors.indexOf(color);
      if (widget.onItemClick != null)
        widget.onItemClick(_selectIndex, Color(color)); //执行回调刷新底部按钮栏颜色
    });
  }

  @override
  void dispose() { //页面销毁后销毁动画控制器
    _controller.dispose();
    super.dispose();
  }
}

//tapbar按钮动画
class TolyAppBarDelegate extends FlowDelegate {
  final int selectIndex; //当前点击的tap下标
  final double factor;   //动画量
  final double height;   //导航栏高度
  
  TolyAppBarDelegate(this.selectIndex, this.factor, this.height);

  @override
  void paintChildren(FlowPaintingContext context) { //paintChildren方法绘制flow子集
    double ox = 0;
    double obx = 0;
    //所有tapbar按钮绘制
    for (int i = 0; i < context.childCount / 2; i++) {
      var cSize = context.getChildSize(i);
      if (i == selectIndex) {
        //当前点击的tap移动高度  context.paintChild绘制每一个子元素
        context.paintChild(i, transform: Matrix4.translationValues(ox, 20.0 * factor - 20, 0.0));
      } else {
        //普通的tap移动高度
        context.paintChild(i, transform: Matrix4.translationValues(ox, -20, 0.0));
      }
      ox += cSize.width; //tap按钮宽度
    }
    //下部小圆点绘制
    for (int i = (context.childCount / 2).floor(); i < context.childCount; i++) {
      if (i - (context.childCount / 2).floor() == selectIndex) {
        obx += context.getChildSize(0).width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(
                obx + context.getChildSize(0).width / 2 - 5, height + 5, 0));
        obx += context.getChildSize(0).width;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
