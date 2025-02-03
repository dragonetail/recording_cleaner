/// 获取联系人用例
///
/// 该用例负责获取联系人列表，支持以下功能：
/// - 分类过滤
/// - 保护策略过滤
/// - 文本搜索
/// - 排序控制
///
/// 遵循Clean Architecture的用例模式，
/// 通过依赖注入接收仓库接口，实现业务逻辑与数据访问的解耦。

import 'package:recording_cleaner/domain/entities/contact_entity.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';

/// 获取联系人用例类
class GetContactsUseCase {
  /// 联系人仓库接口
  final ContactRepository _repository;

  /// 构造函数
  ///
  /// [_repository]：联系人仓库接口实例
  GetContactsUseCase(this._repository);

  /// 执行用例
  ///
  /// 支持以下参数：
  /// - [category]：联系人分类过滤
  ///   * 安全区
  ///   * 临时区
  ///   * 黑名单
  ///   * 未分类
  /// - [protectionStrategy]：保护策略过滤
  ///   * 永久保护
  ///   * 时间保护
  ///   * 空间保护
  ///   * 无保护
  /// - [searchText]：搜索文本（匹配姓名或电话）
  /// - [sortBy]：排序字段
  ///   * 姓名
  ///   * 创建时间
  /// - [ascending]：是否升序排序
  ///
  /// 返回符合条件的[ContactEntity]列表
  Future<List<ContactEntity>> call({
    ContactCategory? category,
    ProtectionStrategy? protectionStrategy,
    String? searchText,
    String? sortBy,
    bool? ascending,
  }) {
    return _repository.getContacts(
      category: category,
      protectionStrategy: protectionStrategy,
      searchText: searchText,
      sortBy: sortBy,
      ascending: ascending,
    );
  }
}
