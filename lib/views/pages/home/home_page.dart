import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';     //状态管理
import 'package:flutter_myUnit/app/convert.dart';    //部件集
import 'package:flutter_myUnit/app/res/cons.dart';   //主题色/语法风格
import 'package:flutter_myUnit/app/router.dart';     //路由
import 'package:flutter_myUnit/blocs/bloc_exp.dart'; //获取数据封装
import 'package:flutter_myUnit/components/permanent/feedback_widget.dart'; //跳转动画封装
import 'package:flutter_myUnit/model/widget_model.dart';            //组件信息-展示-数据模型
import 'package:flutter_myUnit/views/common/empty_page.dart';       //暂无数据页面
// import 'package:flutter_myUnit/views/items/home_item_support.dart'; //主页列表部件
import 'package:flutter_myUnit/views/pages/home/toly_app_bar.dart'; //首页appBar头部导航栏

import 'background.dart'; //关于应用内背景图

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  ScrollController _ctrl;                   //滑动监听器
  double _limitY = 35;                      //Y轴限制高度
  double _height = kToolbarHeight * 2 - 20; //appbar高度 (kToolbarHeight: 头部工具栏高度)

  @override
  void initState() {
    //当页面滑动时出发_updateAppBarHeight事件
    _ctrl = ScrollController()..addListener(_updateAppBarHeight);
    super.initState(); //更新数据
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //获取HomeBloc数据的颜色
    var color = context.bloc<HomeBloc>().state.homeColor;
    return Scaffold(
      //头部多彩导航栏
      appBar: TolyAppBar(
        selectIndex: Cons.tabColors.indexOf(color.value), //选中颜色下标
        preferredSize: Size.fromHeight(_height),          //设置appBar的高度
        onItemClick: _switchTab,                          //点击bar触发的方法
      ),
      body: Stack( //可堆叠
        children: <Widget>[
          BlocBuilder<GlobalBloc, GlobalState>(builder: _buildBackground), //背景图片
          BlocBuilder<HomeBloc, HomeState>(builder: _buildContent)         //卡片列表
        ],
      ),
    );
  }
  //背景图片
  Widget _buildBackground(BuildContext context, GlobalState state) { 
    if (state.showBackGround) {
      return Background();
    }
    return Container();
  }
  //卡片列表
  Widget _buildContent(BuildContext context, HomeState state) {
    if (state is WidgetsLoaded) {
      var items = state.widgets;
      if (items.isEmpty) return EmptyPage(); //数据为空则返回空页面
      return ListView.builder(               //ListView列表部件
          controller: _ctrl,                 //滚动监听器
          itemBuilder: (_, index) => _buildHomeItem(items[index]),
          itemCount: items.length);
    }
    if (state is WidgetsLoadFailed) {
      return Container(
        child: Text('加载数据异常'),
      );
    }
    return Container();
  }
  //卡片部件列表
  Widget _buildHomeItem(WidgetModel model) =>
      BlocBuilder<GlobalBloc, GlobalState>(
        condition: (p, c) => (p.itemStyleIndex != c.itemStyleIndex),
        builder: (_, state) {
          return FeedbackWidget(
                duration: const Duration(milliseconds: 200),
                onPressed: () => _toDetailPage(model),
                child: Text("data"));
                // child: HomeItemSupport.get(model, state.itemStyleIndex));
        },
      );

  //更新头部appbar高度 (_ctrl.offset: Y轴滑动的距离)
  _updateAppBarHeight() {
    if (_ctrl.offset < _limitY * 4) { //刚开始滑动高度一直小于_limitY * 4 / 
      setState(() {                   //所以_height高度一直在减小，当>_limitY * 4时停止减小
        _height = kToolbarHeight * 2 - 20 - _ctrl.offset / 4;
      });
    }
  }
  //点击头部导航栏重新获取数据 index点击的下标
  _switchTab(int index, Color color) {
    if (_ctrl.hasClients) _ctrl.jumpTo(0);
    //获取index下标对应的数据
    BlocProvider.of<HomeBloc>(context).add(EventTabTap(Convert.toFamily(index)));
  }
  //点击卡片跳转到卡片详情
  _toDetailPage(WidgetModel model) async {
    //先获取该卡片的详情数据
    BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetail(model));
    //后跳转到详情页面
    Navigator.pushNamed(context, Router.widget_detail, arguments: model);
  }

  @override
  bool get wantKeepAlive => true;

}
