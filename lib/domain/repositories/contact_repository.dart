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
  /// 获取联系人列表
  Future<List<ContactEntity>> getContacts();

  /// 删除联系人
  Future<void> deleteContacts(List<String> ids);

  /// 获取单个联系人
  Future<ContactEntity?> getContact(String id);

  /// 更新联系人
  Future<void> updateContact(ContactEntity contact);

  /// 获取指定分类的联系人
  Future<List<ContactEntity>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  });

  /// 更新联系人分类
  Future<void> updateContactCategory(String id, ContactCategory category);

  /// 更新联系人保护状态
  Future<void> updateContactProtection(String id, bool isProtected);

  /// 根据电话号码查找联系人
  Future<ContactEntity?> findContactByPhoneNumber(String phoneNumber);

  /// 创建测试数据
  Future<void> createTestData();
}
