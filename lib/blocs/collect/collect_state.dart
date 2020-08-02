import 'package:equatable/equatable.dart';               //相同实例比较
import 'package:flutter_myUnit/model/widget_model.dart'; //组件信息-展示-数据模型

/// 说明: 相同实例比较

class CollectState extends Equatable {
  final List<WidgetModel> widgets;

  CollectState({this.widgets});

  @override
  // TODO: implement props
  List<Object> get props => [widgets];
}
