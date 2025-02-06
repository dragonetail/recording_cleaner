/// 通话录音仓库接口
///
/// 定义了通话录音的基本操作接口，包括：
/// - 获取通话录音列表
/// - 删除通话录音
/// - 获取单个通话录音
/// - 更新通话录音信息
/// - 按联系人获取通话录音
///
/// 该接口遵循仓库模式，用于隔离数据源的具体实现。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';

/// 通话录音仓库接口
abstract class CallRecordingRepository {
  /// 获取通话录音列表
  ///
  /// 支持以下过滤和排序选项：
  /// - [startTime]：开始时间（包含）
  /// - [endTime]：结束时间（不包含）
  /// - [durationFilter]：时长过滤条件
  ///   * 全部
  ///   * 2小时以上
  ///   * 10分钟以上
  ///   * 10分钟以内
  /// - [contactId]：联系人ID过滤
  /// - [callType]：通话类型过滤
  /// - [isImportant]：重要性过滤
  /// - [sortBy]：排序字段
  ///   * 创建时间
  ///   * 时长
  /// - [ascending]：是否升序排序
  ///
  /// 返回符合条件的[CallRecordingEntity]列表
  Future<List<CallRecordingEntity>> getCallRecordings({
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
  ///
  /// [ids]：要删除的通话录音ID列表
  ///
  /// 返回删除操作是否成功
  /// - true：所有文件删除成功
  /// - false：存在删除失败的文件
  Future<bool> deleteCallRecordings(List<String> ids);

  /// 获取通话录音
  ///
  /// [id]：通话录音的唯一标识符
  ///
  /// 返回：
  /// - 如果文件存在，返回对应的[CallRecordingEntity]
  /// - 如果文件不存在，返回null
  Future<CallRecordingEntity?> getCallRecording(String id);

  /// 更新通话录音
  ///
  /// [recording]：包含更新信息的通话录音实体
  ///
  /// 返回更新操作是否成功：
  /// - true：更新成功
  /// - false：更新失败
  Future<bool> updateCallRecording(CallRecordingEntity recording);

  /// 获取联系人的通话录音
  ///
  /// [contactId]：联系人ID
  /// [limit]：返回记录的最大数量
  /// [offset]：跳过的记录数量
  ///
  /// 返回指定联系人的通话录音列表
  Future<List<CallRecordingEntity>> getCallRecordingsByContact(
    String contactId, {
    int? limit,
    int? offset,
  });

  /// 标记通话录音重要性
  ///
  /// [id]：通话录音ID
  /// [isImportant]：是否标记为重要
  ///
  /// 返回更新操作是否成功
  Future<bool> markCallRecordingImportance(String id, bool isImportant);

  /// 切换通话录音的重要性
  Future<void> toggleCallRecordingImportance(String id);
}
