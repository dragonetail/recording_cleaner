/// 联系人数据源接口
///
/// 定义了联系人数据的基本操作接口。
/// 实现类需要处理具体的数据存储和检索逻辑。

import 'package:isar/isar.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/core/utils/hash_utils.dart';
import 'package:recording_cleaner/data/models/contact_model.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 联系人数据源接口
abstract class ContactSource {
  /// 获取联系人列表
  Future<List<ContactModel>> getContacts();

  /// 删除联系人
  Future<void> deleteContacts(List<String> ids);

  /// 获取单个联系人
  Future<ContactModel?> getContact(String id);

  /// 更新联系人
  Future<void> updateContact(ContactModel contact);

  /// 获取指定分类的联系人
  Future<List<ContactModel>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  });

  /// 更新联系人分类
  Future<void> updateContactCategory(String id, ContactCategory category);

  /// 更新联系人保护状态
  Future<void> updateContactProtection(String id, bool isProtected);

  /// 根据电话号码查找联系人
  Future<ContactModel?> findContactByPhoneNumber(String phoneNumber);

  /// 创建测试数据
  Future<void> createTestData();

  /// 批量更新联系人分类
  Future<void> batchUpdateCategory(List<String> ids, ContactCategory category);
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
        for (final id in ids) {
          final contact = await _isar.contactModels.get(HashUtils.fastHash(id));
          if (contact != null) {
            await _isar.contactModels.delete(contact.isarId);
          }
        }
      });
    } catch (e, s) {
      _logger.e('删除联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 获取单个联系人
  Future<ContactModel?> getContact(String id) async {
    try {
      final contact = await _isar.contactModels.get(HashUtils.fastHash(id));
      return contact;
    } catch (e, s) {
      _logger.e('获取联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 更新联系人
  Future<void> updateContact(ContactModel contact) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.contactModels.put(contact);
      });
    } catch (e, s) {
      _logger.e('更新联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 获取指定分类的联系人
  Future<List<ContactModel>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  }) async {
    try {
      final contacts = await _isar.contactModels
          .where()
          .filter()
          .categoryEqualTo(category)
          .findAll();
      return contacts;
    } catch (e, s) {
      _logger.e('获取指定分类的联系人列表失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 更新联系人分类
  Future<void> updateContactCategory(
      String id, ContactCategory category) async {
    try {
      await _isar.writeTxn(() async {
        final contact = await _isar.contactModels.get(HashUtils.fastHash(id));
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
        final contact = await _isar.contactModels.get(HashUtils.fastHash(id));
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
  Future<ContactModel?> findContactByPhoneNumber(String phoneNumber) async {
    try {
      final contact = await _isar.contactModels
          .where()
          .filter()
          .phoneNumberEqualTo(phoneNumber)
          .findFirst();
      return contact;
    } catch (e, s) {
      _logger.e('根据电话号码查找联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> createTestData() async {
    try {
      final now = DateTime.now();
      final testData = [
        ContactModel(
          id: '1',
          name: '张三',
          phoneNumber: '13800138001',
          category: ContactCategory.family,
          isProtected: true,
          createdAt: now,
          updatedAt: now,
        ),
        ContactModel(
          id: '2',
          name: '李四',
          phoneNumber: '13800138002',
          category: ContactCategory.friend,
          createdAt: now,
          updatedAt: now,
        ),
        ContactModel(
          id: '3',
          name: '王五',
          phoneNumber: '13800138003',
          category: ContactCategory.colleague,
          createdAt: now,
          updatedAt: now,
        ),
        ContactModel(
          id: '4',
          name: '赵六',
          phoneNumber: '13800138004',
          category: ContactCategory.customer,
          createdAt: now,
          updatedAt: now,
        ),
        ContactModel(
          id: '5',
          name: '孙七',
          phoneNumber: '13800138005',
          category: ContactCategory.other,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      await _isar.writeTxn(() async {
        for (final contact in testData) {
          await _isar.contactModels.put(contact);
        }
      });
    } catch (e, s) {
      _logger.e('创建测试数据失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> batchUpdateCategory(
      List<String> ids, ContactCategory category) async {
    try {
      await _isar.writeTxn(() async {
        for (final id in ids) {
          final contact = await _isar.contactModels.get(HashUtils.fastHash(id));
          if (contact != null) {
            await _isar.contactModels.put(
              contact.copyWith(category: category),
            );
          }
        }
      });
    } catch (e, s) {
      _logger.e('批量更新联系人分类失败', error: e, stackTrace: s);
      rethrow;
    }
  }
}
