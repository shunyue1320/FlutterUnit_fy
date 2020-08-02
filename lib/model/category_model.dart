import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart'; //相等实例
import 'package:flutter_myUnit/app/utils/color_utils.dart'; //随机颜色
import 'package:flutter_myUnit/storage/po/category_po.dart';  //收藏夹数据库模型
import 'package:intl/intl.dart';  //DateFormat日期格式化

//说明: 收藏夹展示数据模型

class CategoryModel extends Equatable{
  final int id;
  final String name;
  final String info;
  final String createDate;
  final String imageCover;
  final int count;
  final Color color;

  CategoryModel(
      {this.name,
        this.id,
        this.info,
        this.createDate,
        this.imageCover,
        this.count,
        this.color});

  bool get canDelete => id > 1;

  static CategoryModel fromPo(CategoryPo po) {
    return CategoryModel(
      id: po.id,
      name: po.name,
      info: po.info,
      createDate: DateFormat('yyyy-MM-dd HH:mm').format(po.created),
      imageCover: po.image,
      count: po.count,
      color: ColorUtils.parse(po.color),
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    info,
    createDate,
    imageCover,
    count,
    color,
  ];

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, info: $info, createDate: $createDate, imageCover: $imageCover, count: $count, color: $color}';
  }


}