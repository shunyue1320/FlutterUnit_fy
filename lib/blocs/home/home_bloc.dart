import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myUnit/app/enums.dart';    //枚举部件
import 'package:flutter_myUnit/app/res/cons.dart'; //全局风格样式
import 'package:flutter_myUnit/repositories/itf/widget_repository.dart'; //读写数据模型部件集合

import 'home_event.dart'; //检验相等实例
import 'home_state.dart'; //检验相等实例 

/// 说明:

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WidgetRepository repository;

  HomeBloc({@required this.repository});

  @override
  HomeState get initialState => WidgetsLoading(
      homeColor: Color(Cons.tabColors[0]));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is EventTabTap) {
      yield* _mapLoadWidgetToState(event.family);
    }
  }

  Stream<HomeState> _mapLoadWidgetToState(WidgetFamily family) async* {
    try {
      final widgets = await this.repository.loadWidgets(family);
      yield WidgetsLoaded(
          widgets: widgets,
          homeColor: Color(Cons.tabColors[family.index]));
    } catch (err) {
      print(err);
      yield WidgetsLoadFailed();
    }
  }
}
