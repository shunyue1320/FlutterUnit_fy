
import 'package:flutter_myUnit/storage/app_storage.dart';    //初始化数据库
import 'package:flutter_myUnit/app/enums.dart';              //枚举部件
import 'package:flutter_myUnit/storage/dao/node_dao.dart';   //插入数据

import 'package:flutter_myUnit/storage/po/widget_po.dart';   //组件信息-数据库-数据模型
import 'package:flutter_myUnit/storage/dao/widget_dao.dart'; //插入数据
import 'package:flutter_myUnit/model/node_model.dart';       //详情页节点-展示-数据模型
import 'package:flutter_myUnit/model/widget_model.dart';     //组件信息-展示-数据模型
import 'package:flutter_myUnit/repositories/itf/widget_repository.dart'; //插入数据模型部件集合

/// 说明 : Widget数据仓库

class WidgetDbRepository implements WidgetRepository {
  final AppStorage storage;

  WidgetDao _widgetDao;
  NodeDao _nodeDao;

  WidgetDbRepository(this.storage) {
    _widgetDao = WidgetDao(storage);
    _nodeDao = NodeDao(storage);
  }

  @override
  Future<List<WidgetModel>> loadWidgets(WidgetFamily family) async {
    var data = await _widgetDao.queryByFamily(family);
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCollectWidgets() async {
    var data = await _widgetDao.queryCollect();
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    var list = widgets.map(WidgetModel.fromPo).toList();
    return list;
  }

  @override
  Future<List<WidgetModel>> searchWidgets(SearchArgs args) async {
    var data = await _widgetDao.search(args);
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<NodeModel>> loadNode(WidgetModel widgetModel) async {
    var data = await _nodeDao.queryById(widgetModel.id);
    var nodes = data.map((e) => NodeModel.fromJson(e)).toList();
    return nodes;
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    var data = await _widgetDao.queryByIds(id);
    var widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    if (widgets.length > 0) return widgets.map(WidgetModel.fromPo).toList();
    return null;
  }

  @override
  Future<void> toggleCollect(
    int id,
  ) {
    return _widgetDao.toggleCollect(id);
  }


  @override
  Future<bool> collected(int id) async{
    return  await _widgetDao.collected(id);
  }
}
