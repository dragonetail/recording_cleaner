import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

/// 录音列表事件
abstract class RecordingsEvent extends Equatable {
  /// 创建[RecordingsEvent]实例
  const RecordingsEvent();

  @override
  List<Object?> get props => [];
}

/// 加载录音列表事件
class LoadRecordings extends RecordingsEvent {
  /// 创建[LoadRecordings]实例
  const LoadRecordings();
}

/// 删除录音事件
class DeleteRecordings extends RecordingsEvent {
  /// 创建[DeleteRecordings]实例
  const DeleteRecordings(this.ids);

  /// 要删除的录音ID列表
  final List<String> ids;

  @override
  List<Object?> get props => [ids];
}

/// 删除选中的录音事件
class DeleteSelectedRecordings extends RecordingsEvent {
  /// 创建[DeleteSelectedRecordings]实例
  const DeleteSelectedRecordings();
}

/// 进入选择模式事件
class EnterSelectionMode extends RecordingsEvent {
  /// 创建[EnterSelectionMode]实例
  const EnterSelectionMode();
}

/// 退出选择模式事件
class ExitSelectionMode extends RecordingsEvent {
  /// 创建[ExitSelectionMode]实例
  const ExitSelectionMode();
}

/// 切换录音选择状态事件
class ToggleRecordingSelection extends RecordingsEvent {
  /// 创建[ToggleRecordingSelection]实例
  const ToggleRecordingSelection(this.id);

  /// 录音ID
  final String id;

  @override
  List<Object?> get props => [id];
}

/// 切换全选状态事件
class ToggleSelectAll extends RecordingsEvent {
  /// 创建[ToggleSelectAll]实例
  const ToggleSelectAll();
}

/// 更新录音事件
class UpdateRecording extends RecordingsEvent {
  final RecordingEntity recording;

  const UpdateRecording(this.recording);

  @override
  List<Object?> get props => [recording];
}

/// 切换选择模式事件
class ToggleSelectionMode extends RecordingsEvent {
  final bool enabled;

  const ToggleSelectionMode(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

/// 全选/取消全选事件
class SelectAllRecordings extends RecordingsEvent {
  final bool selectAll;

  const SelectAllRecordings(this.selectAll);

  @override
  List<Object?> get props => [selectAll];
}
