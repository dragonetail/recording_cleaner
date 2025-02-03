import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

/// 录音列表状态
class RecordingsState extends Equatable {
  /// 创建[RecordingsState]实例
  const RecordingsState({
    this.recordings = const [],
    this.selectedRecordings = const [],
    this.isLoading = false,
    this.isSelectionMode = false,
    this.error,
  });

  /// 录音列表
  final List<RecordingEntity> recordings;

  /// 已选择的录音ID列表
  final List<String> selectedRecordings;

  /// 是否正在加载
  final bool isLoading;

  /// 是否处于选择模式
  final bool isSelectionMode;

  /// 错误信息
  final String? error;

  /// 初始状态
  factory RecordingsState.initial() {
    return const RecordingsState();
  }

  /// 复制新实例
  RecordingsState copyWith({
    List<RecordingEntity>? recordings,
    List<String>? selectedRecordings,
    bool? isLoading,
    bool? isSelectionMode,
    String? error,
  }) {
    return RecordingsState(
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
