/// 本地通话录音数据源实现
///
/// 使用本地存储实现通话录音数据的管理。
/// 目前使用内存存储，后续可以替换为SQLite或其他本地数据库。

import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:just_audio/just_audio.dart';
import 'package:recording_cleaner/data/models/call_recording_model.dart';
import 'package:recording_cleaner/data/sources/call_recording_source.dart';
import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';

/// 本地通话录音数据源实现
class LocalCallRecordingSource implements CallRecordingSource {
  /// 日志记录器
  final AppLogger logger;

  /// 音频播放器
  final AudioPlayer audioPlayer;

  /// 内存中的通话录音数据
  final List<CallRecordingModel> _recordings = [];

  /// 创建[LocalCallRecordingSource]实例
  LocalCallRecordingSource({
    required this.logger,
    required this.audioPlayer,
  });

  @override
  Future<List<CallRecordingModel>> getCallRecordings({
    DateTime? startTime,
    DateTime? endTime,
    String? durationFilter,
    String? contactId,
    CallType? callType,
    bool? isImportant,
    String? sortBy,
    bool? ascending,
  }) async {
    logger.d(
        '获取通话录音列表，过滤条件：$startTime, $endTime, $durationFilter, $contactId, $callType, $isImportant');

    var filteredRecordings = _recordings.where((recording) {
      if (recording.isDeleted) return false;

      if (startTime != null && recording.createdAt.isBefore(startTime)) {
        return false;
      }
      if (endTime != null && recording.createdAt.isAfter(endTime)) {
        return false;
      }

      if (durationFilter != null) {
        final duration = recording.duration;
        switch (durationFilter) {
          case '2小时以上':
            if (duration.inHours < 2) return false;
            break;
          case '10分钟以上':
            if (duration.inMinutes < 10) return false;
            break;
          case '10分钟以内':
            if (duration.inMinutes >= 10) return false;
            break;
        }
      }

      if (contactId != null && recording.contactId != contactId) return false;
      if (callType != null && recording.callType != callType) return false;
      if (isImportant != null && recording.isImportant != isImportant) {
        return false;
      }

      return true;
    }).toList();

    if (sortBy != null) {
      filteredRecordings.sort((a, b) {
        int comparison;
        switch (sortBy) {
          case '时间':
            comparison = a.createdAt.compareTo(b.createdAt);
            break;
          case '时长':
            comparison = a.duration.compareTo(b.duration);
            break;
          case '大小':
            comparison = a.size.compareTo(b.size);
            break;
          default:
            comparison = 0;
        }
        return ascending == true ? comparison : -comparison;
      });
    }

    return filteredRecordings;
  }

  @override
  Future<bool> deleteCallRecordings(List<String> ids) async {
    logger.d('删除通话录音：$ids');
    try {
      for (final id in ids) {
        final index = _recordings.indexWhere((r) => r.id == id);
        if (index != -1) {
          _recordings[index] = _recordings[index].copyWith(isDeleted: true);
        }
      }
      return true;
    } catch (e) {
      logger.e('删除通话录音失败: $e');
      return false;
    }
  }

  @override
  Future<CallRecordingModel?> getCallRecording(String id) async {
    logger.d('获取通话录音：$id');
    try {
      return _recordings.firstWhere((r) => r.id == id && !r.isDeleted);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateCallRecording(CallRecordingModel recording) async {
    logger.d('更新通话录音：${recording.id}');
    try {
      final index = _recordings.indexWhere((r) => r.id == recording.id);
      if (index != -1) {
        _recordings[index] = recording;
        return true;
      }
      return false;
    } catch (e) {
      logger.e('更新通话录音失败: $e');
      return false;
    }
  }

  @override
  Future<List<CallRecordingModel>> getCallRecordingsByContact(
    String contactId, {
    int? limit,
    int? offset,
  }) async {
    logger.d('获取联系人通话录音：$contactId');
    var recordings = _recordings
        .where((r) => r.contactId == contactId && !r.isDeleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // 按创建时间降序排序

    if (offset != null) {
      recordings = recordings.skip(offset).toList();
    }
    if (limit != null) {
      recordings = recordings.take(limit).toList();
    }

    return recordings;
  }

  @override
  Future<bool> markCallRecordingImportance(String id, bool isImportant) async {
    logger.d('标记通话录音重要性：$id, $isImportant');
    try {
      final index = _recordings.indexWhere((r) => r.id == id);
      if (index != -1) {
        _recordings[index] =
            _recordings[index].copyWith(isImportant: isImportant);
        return true;
      }
      return false;
    } catch (e) {
      logger.e('标记通话录音重要性失败: $e');
      return false;
    }
  }

  @override
  Future<void> createTestData() async {
    logger.i('创建通话录音测试数据');

    final now = DateTime.now();
    final testData = [
      CallRecordingModel(
        id: '1',
        name: '来电-张三',
        path: 'recordings/call_1.mp3',
        size: 1024 * 1024 * 2, // 2MB
        duration: const Duration(minutes: 5),
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
        phoneNumber: '13800138000',
        callType: CallType.incoming,
        contactId: '1',
        isImportant: true,
      ),
      CallRecordingModel(
        id: '2',
        name: '去电-李四',
        path: 'recordings/call_2.mp3',
        size: 1024 * 1024 * 5, // 5MB
        duration: const Duration(minutes: 15),
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 30)),
        phoneNumber: '13800138001',
        callType: CallType.outgoing,
        contactId: '2',
      ),
      CallRecordingModel(
        id: '3',
        name: '来电-王五',
        path: 'recordings/call_3.mp3',
        size: 1024 * 1024 * 10, // 10MB
        duration: const Duration(hours: 1),
        createdAt: now.subtract(const Duration(days: 100)),
        updatedAt: now.subtract(const Duration(days: 100)),
        phoneNumber: '13800138002',
        callType: CallType.incoming,
        contactId: '3',
      ),
      CallRecordingModel(
        id: '4',
        name: '去电-赵六',
        path: 'recordings/call_4.mp3',
        size: 1024 * 1024 * 20, // 20MB
        duration: const Duration(hours: 2, minutes: 30),
        createdAt: now.subtract(const Duration(days: 400)),
        updatedAt: now.subtract(const Duration(days: 400)),
        phoneNumber: '13800138003',
        callType: CallType.outgoing,
        contactId: '4',
        isImportant: true,
      ),
    ];

    _recordings.addAll(testData);
    logger.i('创建了${testData.length}条测试数据');
  }
}
