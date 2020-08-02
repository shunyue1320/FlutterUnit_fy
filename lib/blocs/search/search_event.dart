

import 'package:flutter_myUnit/storage/dao/widget_dao.dart'; //写入数据

abstract class SearchEvent{//事件基
  const SearchEvent();
}

class EventTextChanged extends SearchEvent {
  final SearchArgs args;//参数
  const EventTextChanged({this.args});
}
