import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_myUnit/app/enums.dart';          //枚举部件
import 'package:flutter_myUnit/model/widget_model.dart'; //组件信息-展示-数据模型

import 'coupon_widget_list_item.dart';
import 'techno_widget_list_item.dart';

/// 说明: 主页列表部件

class HomeItemSupport {
  static Widget get(
    WidgetModel model,
    int index,
  ) {
    switch (index) {
      case 0:
        return TechnoWidgetListItem(data: model);
      case 1:
        return TechnoWidgetListItem(data: model, isClip: false);
      case 2:
        return CouponWidgetListItem(data: model);
      case 3:
        return CouponWidgetListItem(hasTopHole: false, data: model);
      case 4:
        return CouponWidgetListItem(
            hasTopHole: true, hasBottomHole: true, data: model);
      case 5:
        return CouponWidgetListItem(isClip: false, data: model);
    }
    return TechnoWidgetListItem(data: model);
  }

  static List<Widget> itemSimples() => [
        TechnoWidgetListItem(data: getContainer()),
        TechnoWidgetListItem(
          data: getContainer(),
          isClip: false,
        ),
        CouponWidgetListItem(data: getContainer()),
        CouponWidgetListItem(hasTopHole: false, data: getContainer()),
        CouponWidgetListItem(
            hasTopHole: true, hasBottomHole: true, data: getContainer()),
        CouponWidgetListItem(isClip: false, data: getContainer()),
      ];

  static WidgetModel getContainer() => WidgetModel(
      id: Random().nextInt(10000),
      name: 'Container',
      nameCN: "",
      lever: 5,
      family: WidgetFamily.statelessWidget,
      info: '用于容纳单个子组件的容器组件。集成了若干个单子组件的功能，如内外边距、形变、装饰、约束等...');
}
