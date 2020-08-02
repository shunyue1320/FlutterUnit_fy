import 'package:flutter_myUnit/model/category_model.dart';     //收藏夹展示数据模型
import 'package:flutter_myUnit/model/widget_model.dart';       //组件信息-展示-数据模型
import 'package:flutter_myUnit/repositories/itf/category_repository.dart'; //负责数据的存储和操作接口
import 'package:flutter_myUnit/storage/app_storage.dart';      //初始化数据库
import 'package:flutter_myUnit/storage/dao/category_dao.dart'; //获取数据库
import 'package:flutter_myUnit/storage/po/category_po.dart';   //收藏夹数据库-数据模型
import 'package:flutter_myUnit/storage/po/widget_po.dart';     //组件信息-数据库-数据模型

/// 说明:创建获取数据库类

class CategoryDbRepository implements CategoryRepository {
  final AppStorage storage; //创建获取数据库类

  CategoryDao _categoryDao;

  CategoryDbRepository(this.storage) {
    _categoryDao = CategoryDao(storage);
  }

  @override
  Future<bool> addCategory(CategoryPo categoryPo) async {
    var success = await _categoryDao.insert(categoryPo);
    return success != -1;
  }

  @override
  Future<bool> check(int categoryId, int widgetId) async {
    return await _categoryDao.existWidgetInCollect(categoryId, widgetId);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _categoryDao.deleteCollect(id);
  }

  @override
  Future<List<CategoryModel>> loadCategories() async {
    var data = await _categoryDao.queryAll();
    var collects = data.map((e) => CategoryPo.fromJson(e)).toList();
    return collects.map(CategoryModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCategoryWidgets({int categoryId = 0}) async {
    var rawData = await _categoryDao.loadCollectWidgets(categoryId);
    var widgets = rawData.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<void> toggleCategory(int categoryId, int widgetId) async {
    return await _categoryDao.toggleCollect( categoryId,  widgetId);
  }

  @override
  Future<List<int>> getCategoryByWidget(int widgetId) async {
    return await _categoryDao.categoryWidgetIds(widgetId);
  }

  @override
  Future<bool> updateCategory(CategoryPo categoryPo) async{
    var success = await _categoryDao.update(categoryPo);
    return success != -1;
  }

//
//  @override
//  Future<List<WidgetModel>> loadCollectWidgets({int collectId = 0}) async {
//
//
//
//  }
//
//  @override
//  Future<bool> checkCollected(int collectId, int widgetId) async {
//
//  }
}
