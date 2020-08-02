
//说明：这个dart文件用来导入 Provider 各页面获取数据封装

library bloc_unit; //library定义这个库的名字

export 'category/category_bloc.dart';
export 'category/category_state.dart';
export 'category/category_event.dart';

export 'category_widget/category_widget_bloc.dart';
export 'category_widget/category_widget_state.dart';
export 'category_widget/category_widget_event.dart';

export 'collect/collect_bloc.dart';
export 'collect/collect_state.dart';
export 'collect/collect_event.dart';

export 'detail/detail_bloc.dart';
export 'detail/detail_state.dart';
export 'detail/detail_event.dart';


export 'home/home_bloc.dart';         //获取home数据事件
export 'home/home_state.dart';
export 'home/home_event.dart';

export 'global/global_bloc.dart';
export 'global/global_state.dart';
export 'global/global_event.dart';

export 'search/search_bloc.dart';
export 'search/search_state.dart';
export 'search/search_event.dart';