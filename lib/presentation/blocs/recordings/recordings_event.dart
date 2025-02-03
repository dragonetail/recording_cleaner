import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

/// 录音列表事件基类
abstract class RecordingsEvent extends Equatable {
  const RecordingsEvent();

  @override
  List<Object?> get props => [];
}

/// 加载录音列表事件
class LoadRecordings extends RecordingsEvent {
  final String? timeFilter;
  final String? durationFilter;
  final String? sortBy;
  final bool? ascending;

  const LoadRecordings({
    this.timeFilter,
    this.durationFilter,
    this.sortBy,
    this.ascending,
  });

  @override
  List<Object?> get props => [timeFilter, durationFilter, sortBy, ascending];
}

/// 删除录音事件
class DeleteRecordings extends RecordingsEvent {
  final List<String> ids;

  const DeleteRecordings(this.ids);

  @override
  List<Object?> get props => [ids];
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

/// 切换录音选择状态事件
class ToggleRecordingSelection extends RecordingsEvent {
  final String id;
  final bool selected;

  const ToggleRecordingSelection(this.id, this.selected);

  @override
  List<Object?> get props => [id, selected];
}

/// 全选/取消全选事件
class SelectAllRecordings extends RecordingsEvent {
  final bool selectAll;

  const SelectAllRecordings(this.selectAll);

  @override
  List<Object?> get props => [selectAll];
}
