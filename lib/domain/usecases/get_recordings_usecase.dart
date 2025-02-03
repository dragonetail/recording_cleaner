/// 获取录音文件用例
///
/// 该用例负责获取录音文件列表，支持以下功能：
/// - 时间过滤
/// - 时长过滤
/// - 排序控制
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';

/// 获取录音文件用例类
class GetRecordingsUseCase {
  /// 录音文件仓库接口
  final RecordingRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：录音文件仓库接口实例
  GetRecordingsUseCase(this._repository);

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
  /// - [sortBy]：排序字段
  ///   * 时间
  ///   * 大小
  /// - [ascending]：是否升序排序
  ///
  /// 返回符合条件的[RecordingEntity]列表
  Future<List<RecordingEntity>> call({
    String? timeFilter,
    String? durationFilter,
    String? sortBy,
    bool? ascending,
  }) {
    return _repository.getRecordings(
      timeFilter: timeFilter,
      durationFilter: durationFilter,
      sortBy: sortBy,
      ascending: ascending,
    );
  }
}
