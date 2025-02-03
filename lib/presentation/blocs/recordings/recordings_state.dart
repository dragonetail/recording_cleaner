import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

/// 录音列表状态
class RecordingsState extends Equatable {
  /// 是否正在加载
  final bool isLoading;

  /// 录音列表
  final List<RecordingEntity> recordings;

  /// 错误信息
  final String? error;

  /// 是否处于选择模式
  final bool isSelectionMode;

  /// 已选择的录音ID集合
  final Set<String> selectedIds;

  /// 创建[RecordingsState]实例
  const RecordingsState({
    this.isLoading = false,
    this.recordings = const [],
    this.error,
    this.isSelectionMode = false,
    this.selectedIds = const {},
  });

  /// 初始状态
  factory RecordingsState.initial() => const RecordingsState();

  /// 加载中状态
  factory RecordingsState.loading() => const RecordingsState(isLoading: true);

  /// 加载成功状态
  factory RecordingsState.loaded(List<RecordingEntity> recordings) =>
      RecordingsState(recordings: recordings);

  /// 加载失败状态
  factory RecordingsState.error(String message) =>
      RecordingsState(error: message);

  /// 复制并创建新实例
  RecordingsState copyWith({
    bool? isLoading,
    List<RecordingEntity>? recordings,
    String? error,
    bool? isSelectionMode,
    Set<String>? selectedIds,
  }) {
    return RecordingsState(
      isLoading: isLoading ?? this.isLoading,
      recordings: recordings ?? this.recordings,
      error: error ?? this.error,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        recordings,
        error,
        isSelectionMode,
        selectedIds,
      ];
}
