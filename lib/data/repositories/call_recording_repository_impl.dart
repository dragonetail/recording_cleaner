/// 通话录音仓库实现
///
/// 实现[CallRecordingRepository]接口，使用[CallRecordingSource]作为数据源。

import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/data/models/call_recording_model.dart';
import 'package:recording_cleaner/data/sources/call_recording_source.dart';
import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';
import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';

/// 通话录音仓库实现
class CallRecordingRepositoryImpl implements CallRecordingRepository {
  /// 通话录音数据源
  final CallRecordingSource _source;
  final AppLogger _logger;

  /// 创建[CallRecordingRepositoryImpl]实例
  CallRecordingRepositoryImpl({
    required CallRecordingSource callRecordingSource,
    required AppLogger logger,
  })  : _source = callRecordingSource,
        _logger = logger;

  @override
  Future<List<CallRecordingEntity>> getCallRecordings({
    DateTime? startTime,
    DateTime? endTime,
    String? durationFilter,
    String? contactId,
    CallType? callType,
    bool? isImportant,
    String? sortBy,
    bool? ascending,
  }) async {
    return _source.getCallRecordings(
      startTime: startTime,
      endTime: endTime,
      durationFilter: durationFilter,
      contactId: contactId,
      callType: callType,
      isImportant: isImportant,
      sortBy: sortBy,
      ascending: ascending,
    );
  }

  @override
  Future<bool> deleteCallRecordings(List<String> ids) async {
    return _source.deleteCallRecordings(ids);
  }

  @override
  Future<CallRecordingEntity?> getCallRecording(String id) async {
    return _source.getCallRecording(id);
  }

  @override
  Future<bool> updateCallRecording(CallRecordingEntity recording) async {
    if (recording is CallRecordingModel) {
      return _source.updateCallRecording(recording);
    }
    return _source
        .updateCallRecording(CallRecordingModel.fromEntity(recording));
  }

  @override
  Future<List<CallRecordingEntity>> getCallRecordingsByContact(
    String contactId, {
    int? limit,
    int? offset,
  }) async {
    return _source.getCallRecordingsByContact(
      contactId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<bool> markCallRecordingImportance(String id, bool isImportant) async {
    return _source.markCallRecordingImportance(id, isImportant);
  }

  @override
  Future<void> toggleCallRecordingImportance(String id) async {
    // 获取当前录音
    final recording = await _source.getCallRecording(id);
    if (recording != null) {
      // 切换重要性
      final updatedRecording =
          recording.copyWith(isImportant: !recording.isImportant);
      await _source.updateCallRecording(updatedRecording);
    }
  }
}
