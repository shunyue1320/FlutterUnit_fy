import 'package:equatable/equatable.dart';
import 'package:flutter_myUnit/model/widget_model.dart'; //组件信息-展示-数据模型

/// 说明: 详情事件

abstract class DetailEvent extends Equatable {
  const DetailEvent();
  @override
  List<Object> get props => [];
}


class FetchWidgetDetail extends DetailEvent {
  final WidgetModel widgetModel;

  const FetchWidgetDetail(this.widgetModel);

  @override
  List<Object> get props => [widgetModel];

  @override
  String toString() {
    return 'FetchWidgetDetail{widgetModel: $widgetModel}';
  }
}


class ResetDetailState extends DetailEvent {

}