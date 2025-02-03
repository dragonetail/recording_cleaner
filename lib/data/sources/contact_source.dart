/// 联系人数据源接口
///
/// 定义了联系人数据的基本操作接口。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:recording_cleaner/data/models/contact_model.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 联系人数据源接口
abstract class ContactSource {
  /// 获取所有联系人
  Future<List<ContactModel>> getContacts({
    ContactCategory? category,
    ProtectionStrategy? protectionStrategy,
    String? searchText,
    String? sortBy,
    bool? ascending,
  });

  /// 删除联系人
  Future<bool> deleteContacts(List<String> ids);

  /// 获取单个联系人
  Future<ContactModel?> getContact(String id);

  /// 更新联系人
  Future<bool> updateContact(ContactModel contact);

  /// 获取指定分类的联系人
  Future<List<ContactModel>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  });

  /// 更新联系人分类
  Future<bool> updateContactCategory(String id, ContactCategory category);

  /// 更新联系人保护策略
  Future<bool> updateContactProtectionStrategy(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  });

  /// 批量更新联系人分类
  Future<bool> batchUpdateCategory(List<String> ids, ContactCategory category);

  /// 批量更新联系人保护策略
  Future<bool> batchUpdateProtectionStrategy(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  });

  /// 根据电话号码查找联系人
  Future<ContactModel?> findContactByPhoneNumber(String phoneNumber);

  /// 创建测试数据
  Future<void> createTestData();
}
