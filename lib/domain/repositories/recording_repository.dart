/// 录音文件仓库接口
///
/// 定义了录音文件的基本操作接口，包括：
/// - 获取录音文件列表
/// - 删除录音文件
/// - 获取单个录音文件
/// - 更新录音文件信息
///
/// 该接口遵循仓库模式，用于隔离数据源的具体实现。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:recording_cleaner/domain/entities/recording_entity.dart';

/// 录音文件仓库接口
abstract class RecordingRepository {
  /// 获取所有录音文件
  ///
  /// 支持以下过滤和排序选项：
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
  Future<List<RecordingEntity>> getRecordings({
    String? timeFilter,
    String? durationFilter,
    String? sortBy,
    bool? ascending,
  });

  /// 删除录音文件
  ///
  /// [ids]：要删除的录音文件ID列表
  ///
  /// 返回删除操作是否成功
  /// - true：所有文件删除成功
  /// - false：存在删除失败的文件
  Future<bool> deleteRecordings(List<String> ids);

  /// 获取单个录音文件
  ///
  /// [id]：录音文件的唯一标识符
  ///
  /// 返回：
  /// - 如果文件存在，返回对应的[RecordingEntity]
  /// - 如果文件不存在，返回null
  Future<RecordingEntity?> getRecording(String id);

  /// 更新录音文件
  ///
  /// [recording]：包含更新信息的录音文件实体
  ///
  /// 返回更新操作是否成功：
  /// - true：更新成功
  /// - false：更新失败
  Future<bool> updateRecording(RecordingEntity recording);
}
