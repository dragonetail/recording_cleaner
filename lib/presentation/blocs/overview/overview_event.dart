/// 概览页面事件
///
/// 定义了概览页面支持的所有事件。

import 'package:equatable/equatable.dart';

/// 概览页面事件基类
abstract class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object?> get props => [];
}

/// 加载概览数据事件
class LoadOverviewData extends OverviewEvent {
  const LoadOverviewData();
}

/// 刷新概览数据事件
class RefreshOverviewData extends OverviewEvent {
  const RefreshOverviewData();
}
