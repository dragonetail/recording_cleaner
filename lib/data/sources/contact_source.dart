/// 联系人数据源接口
///
/// 定义了联系人数据的基本操作接口。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:isar/isar.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
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

/// 联系人数据源
class ContactSourceImpl implements ContactSource {
  /// 创建[ContactSourceImpl]实例
  ContactSourceImpl({
    required AppLogger logger,
    required Isar isar,
  })  : _logger = logger,
        _isar = isar;

  final AppLogger _logger;
  final Isar _isar;

  /// 获取联系人列表
  Future<List<ContactModel>> getContacts() async {
    try {
      final contacts = await _isar.contactModels.where().findAll();
      return contacts;
    } catch (e, s) {
      _logger.e('获取联系人列表失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 删除联系人
  Future<void> deleteContacts(List<String> ids) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.contactModels.deleteAll(ids);
      });
    } catch (e, s) {
      _logger.e('删除联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 更新联系人分类
  Future<void> updateContactCategory(
      String id, ContactCategory category) async {
    try {
      await _isar.writeTxn(() async {
        final contact = await _isar.contactModels.get(id);
        if (contact != null) {
          await _isar.contactModels.put(
            contact.copyWith(category: category),
          );
        }
      });
    } catch (e, s) {
      _logger.e('更新联系人分类失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 更新联系人保护状态
  Future<void> updateContactProtection(String id, bool isProtected) async {
    try {
      await _isar.writeTxn(() async {
        final contact = await _isar.contactModels.get(id);
        if (contact != null) {
          await _isar.contactModels.put(
            contact.copyWith(isProtected: isProtected),
          );
        }
      });
    } catch (e, s) {
      _logger.e('更新联系人保护状态失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ContactModel>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  }) {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<bool> updateContactProtectionStrategy(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<bool> batchUpdateCategory(List<String> ids, ContactCategory category) {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<bool> batchUpdateProtectionStrategy(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<ContactModel?> findContactByPhoneNumber(String phoneNumber) {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<void> createTestData() {
    // Implementation needed
    throw UnimplementedError();
  }
}
