import 'package:equatable/equatable.dart';

/// 通话录音列表事件
abstract class CallRecordingsEvent extends Equatable {
  /// 创建[CallRecordingsEvent]实例
  const CallRecordingsEvent();

  @override
  List<Object?> get props => [];
}

/// 加载通话录音列表事件
class LoadCallRecordings extends CallRecordingsEvent {
  /// 创建[LoadCallRecordings]实例
  const LoadCallRecordings();
}

/// 删除通话录音事件
class DeleteCallRecordings extends CallRecordingsEvent {
  /// 创建[DeleteCallRecordings]实例
  const DeleteCallRecordings(this.ids);

  /// 要删除的通话录音ID列表
  final List<String> ids;

  @override
  List<Object?> get props => [ids];
}

/// 删除选中的通话录音事件
class DeleteSelectedCallRecordings extends CallRecordingsEvent {
  /// 创建[DeleteSelectedCallRecordings]实例
  const DeleteSelectedCallRecordings();
}

/// 进入选择模式事件
class EnterSelectionMode extends CallRecordingsEvent {
  /// 创建[EnterSelectionMode]实例
  const EnterSelectionMode();
}

/// 退出选择模式事件
class ExitSelectionMode extends CallRecordingsEvent {
  /// 创建[ExitSelectionMode]实例
  const ExitSelectionMode();
}

/// 切换通话录音选择状态事件
class ToggleCallRecordingSelection extends CallRecordingsEvent {
  /// 创建[ToggleCallRecordingSelection]实例
  const ToggleCallRecordingSelection(this.id);

  /// 通话录音ID
  final String id;

  @override
  List<Object?> get props => [id];
}

/// 切换全选状态事件
class ToggleSelectAll extends CallRecordingsEvent {
  /// 创建[ToggleSelectAll]实例
  const ToggleSelectAll();
}

/// 切换通话录音重要性事件
class ToggleCallRecordingImportance extends CallRecordingsEvent {
  /// 创建[ToggleCallRecordingImportance]实例
  const ToggleCallRecordingImportance(this.id);

  /// 通话录音ID
  final String id;

  @override
  List<Object?> get props => [id];
}
