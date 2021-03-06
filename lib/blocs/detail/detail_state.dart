import 'package:equatable/equatable.dart';
import 'package:flutter_myUnit/model/node_model.dart';
import 'package:flutter_myUnit/model/widget_model.dart';

/// 说明: 详情状态类

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailWithData extends DetailState {
  final WidgetModel widgetModel;
  final List<WidgetModel> links;
  final List<NodeModel> nodes;

  const DetailWithData({this.widgetModel, this.nodes,this.links});

  @override
  List<Object> get props => [widgetModel,nodes];

  @override
  String toString() {
    return 'DetailWithData{widget: $widgetModel, nodes: $nodes}';
  }

}

class DetailLoading extends DetailState {}

class DetailEmpty extends DetailState {}

class DetailFailed extends DetailState {}