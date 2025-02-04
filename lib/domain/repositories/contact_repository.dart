/// 联系人仓库接口
///
/// 定义了联系人的基本操作接口，包括：
/// - 获取联系人列表
/// - 删除联系人
/// - 获取单个联系人
/// - 更新联系人信息
/// - 按分类获取联系人
/// - 管理联系人分类和保护策略
///
/// 该接口遵循仓库模式，用于隔离数据源的具体实现。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 联系人仓库接口
abstract class ContactRepository {
  /// 获取所有联系人
  ///
  /// 支持以下过滤和排序选项：
  /// - [category]：联系人分类过滤
  /// - [protectionStrategy]：保护策略过滤
  /// - [searchText]：搜索文本（匹配姓名或电话）
  /// - [sortBy]：排序字段
  ///   * 姓名
  ///   * 创建时间
  /// - [ascending]：是否升序排序
  ///
  /// 返回符合条件的[ContactEntity]列表
  Future<List<ContactEntity>> getContacts({
    ContactCategory? category,
    ProtectionStrategy? protectionStrategy,
    String? searchText,
    String? sortBy,
    bool? ascending,
  });

  /// 删除联系人
  ///
  /// [ids]：要删除的联系人ID列表
  ///
  /// 返回删除操作是否成功
  /// - true：所有联系人删除成功
  /// - false：存在删除失败的联系人
  Future<bool> deleteContacts(List<String> ids);

  /// 获取单个联系人
  ///
  /// [id]：联系人的唯一标识符
  ///
  /// 返回：
  /// - 如果联系人存在，返回对应的[ContactEntity]
  /// - 如果联系人不存在，返回null
  Future<ContactEntity?> getContact(String id);

  /// 更新联系人
  ///
  /// [contact]：包含更新信息的联系人实体
  ///
  /// 返回更新操作是否成功：
  /// - true：更新成功
  /// - false：更新失败
  Future<bool> updateContact(ContactEntity contact);

  /// 获取指定分类的联系人
  ///
  /// [category]：联系人分类
  /// [limit]：返回记录的最大数量
  /// [offset]：跳过的记录数量
  ///
  /// 返回指定分类的联系人列表
  Future<List<ContactEntity>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  });

  /// 更新联系人分类
  ///
  /// [id]：联系人ID
  /// [category]：新的分类
  ///
  /// 返回更新操作是否成功
  Future<bool> updateContactCategory(String id, ContactCategory category);

  /// 更新联系人保护策略
  ///
  /// [id]：联系人ID
  /// [strategy]：新的保护策略
  /// [param]：保护策略参数
  ///
  /// 返回更新操作是否成功
  Future<bool> updateContactProtectionStrategy(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  });

  /// 批量更新联系人分类
  ///
  /// [ids]：联系人ID列表
  /// [category]：新的分类
  ///
  /// 返回更新操作是否成功
  Future<bool> batchUpdateCategory(List<String> ids, ContactCategory category);

  /// 批量更新联系人保护策略
  ///
  /// [ids]：联系人ID列表
  /// [strategy]：新的保护策略
  /// [param]：保护策略参数
  ///
  /// 返回更新操作是否成功
  Future<bool> batchUpdateProtectionStrategy(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  });

  /// 根据电话号码查找联系人
  ///
  /// [phoneNumber]：电话号码
  ///
  /// 返回：
  /// - 如果找到匹配的联系人，返回对应的[ContactEntity]
  /// - 如果未找到匹配的联系人，返回null
  Future<ContactEntity?> findContactByPhoneNumber(String phoneNumber);

  /// 更新联系人保护状态
  Future<void> updateContactProtection(String id, bool isProtected);
}
