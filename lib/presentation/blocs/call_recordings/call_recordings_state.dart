import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';

/// 通话录音列表状态
class CallRecordingsState extends Equatable {
  /// 创建[CallRecordingsState]实例
  const CallRecordingsState({
    this.recordings = const [],
    this.selectedRecordings = const [],
    this.isLoading = false,
    this.isSelectionMode = false,
    this.error,
  });

  /// 通话录音列表
  final List<CallRecordingEntity> recordings;

  /// 已选择的通话录音ID列表
  final List<String> selectedRecordings;

  /// 是否正在加载
  final bool isLoading;

  /// 是否处于选择模式
  final bool isSelectionMode;

  /// 错误信息
  final String? error;

  /// 初始状态
  factory CallRecordingsState.initial() {
    return const CallRecordingsState();
  }

  /// 复制新实例
  CallRecordingsState copyWith({
    List<CallRecordingEntity>? recordings,
    List<String>? selectedRecordings,
    bool? isLoading,
    bool? isSelectionMode,
    String? error,
  }) {
    return CallRecordingsState(
      recordings: recordings ?? this.recordings,
      selectedRecordings: selectedRecordings ?? this.selectedRecordings,
      isLoading: isLoading ?? this.isLoading,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        recordings,
        selectedRecordings,
        isLoading,
        isSelectionMode,
        error,
      ];
}
