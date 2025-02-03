/// 删除录音文件用例
///
/// 该用例负责删除指定的录音文件。
/// 支持批量删除操作，通过文件ID列表指定要删除的文件。
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/repositories/recording_repository.dart';

/// 删除录音文件用例类
class DeleteRecordingsUseCase {
  /// 录音文件仓库接口
  final RecordingRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：录音文件仓库接口实例
  DeleteRecordingsUseCase(this._repository);

  /// 执行用例
  ///
  /// [ids]：要删除的录音文件ID列表
  ///
  /// 返回删除操作是否成功：
  /// - true：所有文件删除成功
  /// - false：存在删除失败的文件
  Future<bool> call(List<String> ids) {
    return _repository.deleteRecordings(ids);
  }
}
