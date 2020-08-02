import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myUnit/model/widget_model.dart'; //组件信息-展示-数据模型

/// 说明: widget状态类

abstract class HomeState extends Equatable {
  final Color homeColor;

  const HomeState({this.homeColor});

  @override
  List<Object> get props => [homeColor];
}

class WidgetsLoading extends HomeState {
  const WidgetsLoading({homeColor})
      : super(homeColor: homeColor);
  @override
  List<Object> get props => [homeColor];
}

class WidgetsLoaded extends HomeState {
  final List<WidgetModel> widgets;

  const WidgetsLoaded({homeColor, barHeight, this.widgets = const []})
      : super(homeColor: homeColor);

  @override
  List<Object> get props => [homeColor,widgets];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class WidgetsLoadFailed extends HomeState {
  const WidgetsLoadFailed({homeColor, barHeight})
      : super(homeColor: homeColor);
  @override
  List<Object> get props => [homeColor];
}
