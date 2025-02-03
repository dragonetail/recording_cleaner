/// 通话录音数据源接口
///
/// 定义了通话录音数据的基本操作接口。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:recording_cleaner/data/models/call_recording_model.dart';
import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';

/// 通话录音数据源接口
abstract class CallRecordingSource {
  /// 获取通话录音列表
  Future<List<CallRecordingModel>> getCallRecordings({
    DateTime? startTime,
    DateTime? endTime,
    String? durationFilter,
    String? contactId,
    CallType? callType,
    bool? isImportant,
    String? sortBy,
    bool? ascending,
  });

  /// 删除通话录音
  Future<bool> deleteCallRecordings(List<String> ids);

  /// 获取通话录音
  Future<CallRecordingModel?> getCallRecording(String id);

  /// 更新通话录音
  Future<bool> updateCallRecording(CallRecordingModel recording);

  /// 获取联系人的通话录音
  Future<List<CallRecordingModel>> getCallRecordingsByContact(
    String contactId, {
    int? limit,
    int? offset,
  });

  /// 标记通话录音重要性
  Future<bool> markCallRecordingImportance(String id, bool isImportant);

  /// 创建测试数据
  Future<void> createTestData();
}
