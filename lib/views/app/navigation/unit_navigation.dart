import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';     //状态管理
import 'package:flutter_myUnit/app/res/cons.dart';   //主题颜色语法/高亮
import 'package:flutter_myUnit/app/router.dart';     //路由
import 'package:flutter_myUnit/blocs/bloc_exp.dart'; //各页面获取数据封装
import 'package:flutter_myUnit/views/app/navigation/unit_bottom_bar.dart';   //底部左右两个导航栏按钮
// import 'package:flutter_myUnit/views/pages/category/collect_page.dart';      //收藏集页面
// import 'package:flutter_myUnit/views/pages/home/home_drawer.dart';           //左抽屉
// import 'package:flutter_myUnit/views/pages/category/home_right_drawer.dart'; //右抽屉
import 'package:flutter_myUnit/views/pages/home/home_page.dart';             //主页面(部件列表页面)


class UnitNavigation extends StatefulWidget {
  @override
  _UnitNavigationState createState() => _UnitNavigationState();
}

class _UnitNavigationState extends State<UnitNavigation> {
  PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) => Scaffold(
            // drawer: HomeDrawer(color:state.homeColor), //左滑页抽屉
            // endDrawer: HomeRightDrawer(color: state.homeColor), //右滑页抽屉
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //定位:底部中间搜索按钮
            floatingActionButton: _buildSearchButton(state.homeColor), //底部中间搜索按钮
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                HomePage(),     //主页卡片页
                // CollectPage(),  //收藏页
              ],
            ),
            bottomNavigationBar: UnitBottomBar(  //底部左右两个导航栏
                color: state.homeColor,
                itemData: Cons.ICONS_MAP,
                onItemClick: _onTapNav
            )
        )
    );
  }

  Widget _buildSearchButton(Color color) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: color,
      child: const Icon(Icons.search),
      onPressed: () => Navigator.of(context).pushNamed(Router.search),
    );
  }

  _onTapNav(int index) {
    _controller.animateToPage(index,
        duration:const Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn); //点击后切换动画曲线
    if (index == 1) { //如果是收藏页则获取数据
      BlocProvider.of<CollectBloc>(context).add(EventSetCollectData());
    }
  }
}
