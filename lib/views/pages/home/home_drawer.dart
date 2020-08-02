import 'package:flutter/material.dart';
import 'package:flutter_myUnit/app/router.dart';         //路由
import 'package:flutter_myUnit/app/style/TolyIcon.dart'; //icon颜色风格
import 'package:flutter_myUnit/components/flutter/no_div_expansion_tile.dart'; //风格管理
import 'package:flutter_myUnit/views/common/unit_drawer_header.dart';          //抽屉头部内容样式

/// 说明:左抽屉

class HomeDrawer extends StatelessWidget {
  final Color color;

  HomeDrawer({this.color});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        color: color.withAlpha(33),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UnitDrawerHeader(color: color),
            _buildItem(context, TolyIcon.icon_them, '应用设置', Router.setting),
            _buildItem(context, TolyIcon.icon_layout, '数据统计', null),
            Divider(height: 1),
            _buildFlutterUnit(context),
            _buildItem(context, TolyIcon.icon_code, 'Dart 手册', null),
            Divider(height: 1),
            _buildItem(context, Icons.info, '关于应用', Router.about_app),
            _buildItem(context, TolyIcon.icon_kafei, '联系本王', Router.about_me),
          ],
        ),
      );

  Widget _buildFlutterUnit(BuildContext context) => NoBorderExpansionTile(
        backgroundColor: Colors.white70,
        leading: Icon(
          Icons.extension,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Flutter 集录'),
        children: <Widget>[
          _buildItem(context, TolyIcon.icon_tag, '属性集录', Router.attr),
          _buildItem(context, Icons.palette, '绘画集录', Router.paint),
          _buildItem(context, Icons.widgets, '布局集录', Router.layout),
          _buildItem(context, TolyIcon.icon_bug, '要点集录', Router.bug),
        ],
      );

  Widget _buildItem(
          BuildContext context, IconData icon, String title, String linkTo) =>
      ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
        trailing:
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        onTap: () {
          if (linkTo != null && linkTo.isNotEmpty) {
            Navigator.of(context).pushNamed(linkTo);
          }
        },
      );
}
