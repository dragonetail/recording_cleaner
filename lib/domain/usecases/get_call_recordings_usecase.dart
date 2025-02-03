/// 获取通话录音用例
///
/// 该用例负责获取通话录音列表，支持以下功能：
/// - 时间过滤
/// - 时长过滤
/// - 联系人过滤
/// - 通话类型过滤
/// - 重要性过滤
/// - 排序控制
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';
import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';

/// 获取通话录音用例类
class GetCallRecordingsUseCase {
  /// 通话录音仓库接口
  final CallRecordingRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：通话录音仓库接口实例
  GetCallRecordingsUseCase(this._repository);

  /// 执行用例
  ///
  /// 支持以下参数：
  /// - [timeFilter]：时间过滤条件
  ///   * 全部
  ///   * 一年以前
  ///   * 90天以前
  ///   * 最近90天内
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
  Future<List<CallRecordingEntity>> call({
    DateTime? startTime,
    DateTime? endTime,
    String? durationFilter,
    String? contactId,
    CallType? callType,
    bool? isImportant,
    String? sortBy,
    bool? ascending,
  }) {
    return _repository.getCallRecordings(
      startTime: startTime,
      endTime: endTime,
      durationFilter: durationFilter,
      contactId: contactId,
      callType: callType,
      isImportant: isImportant,
      sortBy: sortBy ?? '创建时间', // 默认按创建时间排序
      ascending: ascending ?? false, // 默认降序（最新的在前面）
    );
  }
}
