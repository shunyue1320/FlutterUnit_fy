
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';                         //分享平台
import 'package:flutter_myUnit/app/res/cons.dart';              //全局样式
import 'package:flutter_myUnit/app/res/sp.dart';                //变量名下划线化
import 'package:flutter_myUnit/blocs/global/global_state.dart'; //全局状态
import 'package:shared_preferences/shared_preferences.dart';    //键值对存储库
import 'package:sqflite/sqflite.dart';                          //数据库
import 'package:path/path.dart' as path;                        //路径

// 说明: 创建数据库

class AppStorage {
  SharedPreferences _sp;
  Database _database;

  Future<SharedPreferences> get sp async {
    _sp = _sp ?? await SharedPreferences.getInstance();
    return _sp;
  }

  Future<Database> get db async {
    _database = _database ?? await initDb();
    return _database;
  }

  // 初始化 App 固化的配置数据
  Future<GlobalState> initApp() async {
    var prefs = await sp;
    _database = await initDb();
    var showBg = prefs.getBool(SP.showBackground) ?? true;
    var themeIndex = prefs.getInt(SP.themeColorIndex) ?? 4;
    var fontIndex = prefs.getInt(SP.fontFamily) ?? 1;
    var codeIndex = prefs.getInt(SP.codeStyleIndex) ?? 0;
    var itemStyleIndex = prefs.getInt(SP.itemStyleIndex) ?? 0;

    return GlobalState(
        showBackGround: showBg,
        themeColor: Cons.themeColorSupport.keys.toList()[themeIndex],
        fontFamily: Cons.fontFamilySupport[fontIndex],
        itemStyleIndex: itemStyleIndex,
        codeStyleIndex: codeIndex);
  }

  // 初始化数据库
  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var dbPath = path.join(databasesPath, "flutter.db");
    var exists = await databaseExists(dbPath);
    if (!exists) {
      try {
        await Directory(path.dirname(dbPath)).create(recursive: true);
        print("========= assets ======拷贝完成====");
      } catch (_) {}
      ByteData data = await rootBundle.load(path.join("assets", "flutter.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
    } else {
      print("========= 数据库 ======已存在====");
    }
    return await openDatabase(dbPath, readOnly: false);
  }
}
