/// 更新联系人分类用例
///
/// 该用例负责更新联系人的分类。
/// 支持单个和批量更新操作。
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/entities/contact_entity.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';

/// 更新联系人分类用例类
class UpdateContactCategoryUseCase {
  /// 联系人仓库接口
  final ContactRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：联系人仓库接口实例
  UpdateContactCategoryUseCase(this._repository);

  /// 执行用例（单个更新）
  ///
  /// [id]：联系人ID
  /// [category]：新的分类
  ///
  /// 返回更新操作是否成功：
  /// - true：更新成功
  /// - false：更新失败
  Future<bool> call(String id, ContactCategory category) {
    return _repository.updateContactCategory(id, category);
  }

  /// 执行用例（批量更新）
  ///
  /// [ids]：联系人ID列表
  /// [category]：新的分类
  ///
  /// 返回更新操作是否成功：
  /// - true：所有联系人更新成功
  /// - false：存在更新失败的联系人
  Future<bool> batch(List<String> ids, ContactCategory category) {
    return _repository.batchUpdateCategory(ids, category);
  }
}
