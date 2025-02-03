/// 更新联系人保护策略用例
///
/// 该用例负责更新联系人的保护策略。
/// 支持单个和批量更新操作。
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/entities/contact_entity.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';

/// 更新联系人保护策略用例类
class UpdateContactProtectionUseCase {
  /// 联系人仓库接口
  final ContactRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：联系人仓库接口实例
  UpdateContactProtectionUseCase(this._repository);

  /// 执行用例（单个更新）
  ///
  /// [id]：联系人ID
  /// [strategy]：新的保护策略
  /// [param]：保护策略参数
  ///   * 时间保护：保存天数
  ///   * 空间保护：保存字节数
  ///
  /// 返回更新操作是否成功：
  /// - true：更新成功
  /// - false：更新失败
  Future<bool> call(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    return _repository.updateContactProtectionStrategy(
      id,
      strategy,
      param: param,
    );
  }

  /// 执行用例（批量更新）
  ///
  /// [ids]：联系人ID列表
  /// [strategy]：新的保护策略
  /// [param]：保护策略参数
  ///   * 时间保护：保存天数
  ///   * 空间保护：保存字节数
  ///
  /// 返回更新操作是否成功：
  /// - true：所有联系人更新成功
  /// - false：存在更新失败的联系人
  Future<bool> batch(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    return _repository.batchUpdateProtectionStrategy(
      ids,
      strategy,
      param: param,
    );
  }
}
