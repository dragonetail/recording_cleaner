/// 删除通话录音用例
///
/// 该用例负责删除指定的通话录音。
/// 支持批量删除操作，通过文件ID列表指定要删除的文件。
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';

/// 删除通话录音用例类
class DeleteCallRecordingsUseCase {
  /// 通话录音仓库接口
  final CallRecordingRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：通话录音仓库接口实例
  DeleteCallRecordingsUseCase(this._repository);

  /// 执行用例
  ///
  /// [ids]：要删除的通话录音ID列表
  ///
  /// 返回删除操作是否成功：
  /// - true：所有文件删除成功
  /// - false：存在删除失败的文件
  Future<bool> call(List<String> ids) {
    return _repository.deleteCallRecordings(ids);
  }
}
