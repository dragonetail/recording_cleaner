/// 标记通话录音重要性用例
///
/// 该用例负责标记通话录音的重要性。
/// 重要的通话录音将受到特殊保护。
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';

/// 标记通话录音重要性用例类
class MarkCallRecordingImportanceUseCase {
  /// 通话录音仓库接口
  final CallRecordingRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：通话录音仓库接口实例
  MarkCallRecordingImportanceUseCase(this._repository);

  /// 执行用例
  ///
  /// [id]：通话录音ID
  /// [isImportant]：是否标记为重要
  ///
  /// 返回更新操作是否成功：
  /// - true：更新成功
  /// - false：更新失败
  Future<bool> call(String id, bool isImportant) {
    return _repository.markCallRecordingImportance(id, isImportant);
  }
}
