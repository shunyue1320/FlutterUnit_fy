import 'package:equatable/equatable.dart';      //校验相等实例
import 'package:flutter_myUnit/app/enums.dart'; //枚举部件

/// 说明: 

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class EventTabTap extends HomeEvent {
  final WidgetFamily family;

  EventTabTap(this.family);

}


