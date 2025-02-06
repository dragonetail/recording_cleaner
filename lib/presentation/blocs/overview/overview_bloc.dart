/// 概览页面BLoC
///
/// 负责处理概览页面的业务逻辑，包括：
/// - 加载和刷新概览数据
/// - 清理存储空间
/// - 恢复测试数据

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_event.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_state.dart';

/// 概览页面BLoC
class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final AppLogger _logger;
  final RecordingRepository _recordingRepository;
  final CallRecordingRepository _callRecordingRepository;

  /// 创建[OverviewBloc]实例
  OverviewBloc({
    required AppLogger logger,
    required RecordingRepository recordingRepository,
    required CallRecordingRepository callRecordingRepository,
  })  : _logger = logger,
        _recordingRepository = recordingRepository,
        _callRecordingRepository = callRecordingRepository,
        super(OverviewState.initial()) {
    on<LoadOverviewData>(_onLoadOverviewData);
    on<RefreshOverviewData>(_onRefreshOverviewData);
    on<CleanStorage>(_onCleanStorage);
    on<RestoreTestData>(_onRestoreTestData);
  }

  /// 处理[LoadOverviewData]事件
  Future<void> _onLoadOverviewData(
    LoadOverviewData event,
    Emitter<OverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      // 获取录音文件统计
      final recordings = await _recordingRepository.getRecordings();
      final recordingsCount = recordings.length;
      final recordingsDuration = recordings.fold<Duration>(
        Duration.zero,
        (total, recording) => total + recording.duration,
      );
      final recordingsSize = recordings.fold<int>(
        0,
        (total, recording) => total + recording.size,
      );

      // 获取通话录音统计
      final callRecordings = await _callRecordingRepository.getCallRecordings();
      final callRecordingsCount = callRecordings.length;
      final callRecordingsDuration = callRecordings.fold<Duration>(
        Duration.zero,
        (total, recording) => total + recording.duration,
      );
      final callRecordingsSize = callRecordings.fold<int>(
        0,
        (total, recording) => total + recording.size,
      );

      // 计算存储空间使用情况
      final usedStorage = recordingsSize + callRecordingsSize;
      const totalStorage = 1024 * 1024 * 1024 * 10; // 10GB
      final storageUsage = usedStorage / totalStorage;

      emit(state.copyWith(
        isLoading: false,
        storageUsage: storageUsage,
        usedStorage: usedStorage,
        totalStorage: totalStorage,
        recordingsCount: recordingsCount,
        recordingsDuration: recordingsDuration,
        recordingsSize: recordingsSize,
        callRecordingsCount: callRecordingsCount,
        callRecordingsDuration: callRecordingsDuration,
        callRecordingsSize: callRecordingsSize,
      ));
    } catch (e, stackTrace) {
      _logger.e('加载概览数据失败', error: e, stackTrace: stackTrace);
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// 处理[RefreshOverviewData]事件
  Future<void> _onRefreshOverviewData(
    RefreshOverviewData event,
    Emitter<OverviewState> emit,
  ) async {
    await _onLoadOverviewData(const LoadOverviewData(), emit);
  }

  /// 处理[CleanStorage]事件
  Future<void> _onCleanStorage(
    CleanStorage event,
    Emitter<OverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      // TODO: 实现清理逻辑

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      _logger.e('清理存储空间失败: $e');
      emit(OverviewState.error('清理存储空间失败'));
    }
  }

  /// 处理[RestoreTestData]事件
  Future<void> _onRestoreTestData(
    RestoreTestData event,
    Emitter<OverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      // TODO: 实现恢复测试数据逻辑

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      _logger.e('恢复测试数据失败: $e');
      emit(OverviewState.error('恢复测试数据失败'));
    }
  }
}

class CleanStorage extends OverviewEvent {}

class RestoreTestData extends OverviewEvent {}
