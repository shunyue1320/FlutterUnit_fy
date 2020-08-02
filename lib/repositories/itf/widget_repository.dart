

import 'package:flutter_myUnit/app/enums.dart';              //枚举部件
import 'package:flutter_myUnit/storage/dao/widget_dao.dart'; //写入数据
import 'package:flutter_myUnit/model/node_model.dart';       //详情页节点-展示-数据模型
import 'package:flutter_myUnit/model/widget_model.dart';     //组件信息-展示-数据模型

//说明：部件集合

abstract class WidgetRepository {

  Future<List<WidgetModel>> loadWidgets(WidgetFamily family);

  Future<List<WidgetModel>> loadWidget(List<int> ids);

  Future<List<WidgetModel>> searchWidgets(SearchArgs args);
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel);

  Future<void> toggleCollect(int id);

  Future<List<WidgetModel>> loadCollectWidgets();

  Future<bool> collected(int id);
}