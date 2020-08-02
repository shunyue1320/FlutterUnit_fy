import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';      //状态管理
import 'package:flutter_myUnit/app/router.dart';      //路由
import 'package:flutter_myUnit/blocs/bloc_exp.dart';  //操作存储库
import 'package:flutter_myUnit/views/app/splash/unit_splash.dart'; //UnitSplash 进入动画

/// 说明: 根页面

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
      return BlocProvider<CategoryWidgetBloc>( 
        //CategoryWidgetBloc 获取数据事件
        create: (_) => CategoryWidgetBloc(
            categoryBloc: BlocProvider.of<CategoryBloc>(context)),
        child: MaterialApp(
//            debugShowMaterialGrid: true,         //调试显示材料网格
            showPerformanceOverlay: state.showPerformanceOverlay,
//            showSemanticsDebugger: true,         //显示语义调试器
//            checkerboardOffscreenLayers:true,    //显示多视图叠加渲染性能
//            checkerboardRasterCacheImages:true,  //显示检查缓存图片性能
            title: 'Flutter Unit',                 //页面标题
            debugShowCheckedModeBanner: false,     //不显示debug
            onGenerateRoute: Router.generateRoute, //onGenerateRoute 路由拦截器
            theme: ThemeData(                      //主题样式
              primarySwatch: state.themeColor,     //主色，决定导航栏颜色
              fontFamily: state.fontFamily,        //文字字体
            ),
            //根页面部件
            home: UnitSplash()),
      );
    });
  }
}


// onGenerateRoute 路由拦截器：
//当调用Navigator.pushNamed(…)打开命名路由时，
//如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；
//如果路由表中没有注册，才会调用onGenerateRoute来生成路由