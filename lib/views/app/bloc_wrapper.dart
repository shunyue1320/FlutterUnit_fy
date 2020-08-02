import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';          //状态管理
import 'package:flutter_myUnit/app/enums.dart';           //可枚举部件名对象
import 'package:flutter_myUnit/blocs/bloc_exp.dart';      //导入所有的状态控制
import 'package:flutter_myUnit/repositories/impl/catagory_db_repository.dart'; //创建获取数据库类
import 'package:flutter_myUnit/repositories/impl/widget_db_repository.dart';   //Widget数据仓库
import 'package:flutter_myUnit/storage/app_storage.dart'; //创建数据库

/// 说明:MultiBlocProvider 全局状态管理 组件间通信

final storage = AppStorage();

class BlocWrapper extends StatelessWidget {
  final Widget child;

  BlocWrapper({this.child});

  final repository = WidgetDbRepository(storage);
  final categoryRepo = CategoryDbRepository(storage);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//使用MultiBlocProvider包裹 注册Provider 组件间通信
        providers: [
      //Bloc提供器
      BlocProvider<GlobalBloc>(
        //GlobalBloc 获取数据事件
          create: (_) => GlobalBloc(storage)..add(EventInitApp())),

      BlocProvider<HomeBloc>(
        //HomeBloc 获取数据事件
          create: (_) => HomeBloc(repository: repository)
            ..add(EventTabTap(WidgetFamily.statelessWidget))),

      BlocProvider<DetailBloc>(
        //DetailBloc 获取数据事件
          create: (_) => DetailBloc(repository: repository)),
      BlocProvider<CategoryBloc>(
        //CategoryBloc 获取数据事件
        //lazy: false,
          create: (_) =>
              CategoryBloc(repository: categoryRepo)..add(EventLoadCategory())),

      BlocProvider<CollectBloc>(
        //CollectBloc 获取数据事件
          create: (_) =>
              CollectBloc(repository: repository)..add(EventSetCollectData())),
        //SearchBloc 获取数据事件
      BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(repository: repository)),
    ], child: child);
  }
}
