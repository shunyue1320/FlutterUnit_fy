import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myUnit/storage/app_storage.dart';    //创建数据库
import 'package:flutter_myUnit/app/res/cons.dart';           //全局风格
import 'package:flutter_myUnit/app/res/sp.dart';             //变量名下划线化
import 'package:shared_preferences/shared_preferences.dart'; //键值对存储库

import 'global_event.dart';
import 'global_state.dart';

/// 说明: 全局信息的bloc

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  @override
  GlobalState get initialState => GlobalState();

 final AppStorage storage ;


  GlobalBloc(this.storage);

  Future<SharedPreferences> get sp => storage.sp;

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is EventInitApp) {
      yield await storage.initApp();
    }

    if (event is EventSwitchFontFamily) {
      var familyIndex = Cons.fontFamilySupport.indexOf(event.family);
      await sp
        ..setInt(SP.fontFamily, familyIndex); //固化数据
      yield state.copyWith(fontFamily: event.family);
    }

    if (event is EventSwitchThemeColor) {
      var themeIndex =
          Cons.themeColorSupport.keys.toList().indexOf(event.color);
      await sp
        ..setInt(SP.themeColorIndex, themeIndex); //固化数据
      yield state.copyWith(themeColor: event.color);
    }

    if (event is EventSwitchShowBg) {
      await sp
        ..setBool(SP.showBackground, event.show); //固化数据
      yield state.copyWith(showBackGround: event.show);
    }
    if (event is EventSwitchShowOver) {
      yield state.copyWith(showPerformanceOverlay: event.show);
    }

    if (event is EventSwitchCoderTheme) {
      await sp
        ..setInt(SP.codeStyleIndex, event.codeStyleIndex); //固化数据
      yield state.copyWith(codeStyleIndex: event.codeStyleIndex);
    }
    if (event is EventChangeItemStyle) {
      await sp
        ..setInt(SP.itemStyleIndex, event.index); //固化数据
      yield state.copyWith(itemStyleIndex: event.index);
    }
  }
}
