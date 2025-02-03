/// 本地联系人数据源实现
///
/// 使用本地存储实现联系人数据的管理。
/// 目前使用内存存储，后续可以替换为SQLite或其他本地数据库。

import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/data/models/contact_model.dart';
import 'package:recording_cleaner/data/sources/contact_source.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 本地联系人数据源实现
class LocalContactSource implements ContactSource {
  /// 日志记录器
  final AppLogger logger;

  /// 内存中的联系人数据
  final List<ContactModel> _contacts = [];

  /// 创建[LocalContactSource]实例
  LocalContactSource({
    required this.logger,
  });

  @override
  Future<List<ContactModel>> getContacts({
    ContactCategory? category,
    ProtectionStrategy? protectionStrategy,
    String? searchText,
    String? sortBy,
    bool? ascending,
  }) async {
    logger.d('获取联系人列表，过滤条件：$category, $protectionStrategy, $searchText');

    var filteredContacts = _contacts.where((contact) {
      if (contact.isDeleted) return false;

      if (category != null && contact.category != category) return false;
      if (protectionStrategy != null &&
          contact.protectionStrategy != protectionStrategy) return false;

      if (searchText != null && searchText.isNotEmpty) {
        final searchLower = searchText.toLowerCase();
        return contact.name.toLowerCase().contains(searchLower) ||
            contact.phoneNumber.contains(searchLower);
      }

      return true;
    }).toList();

    if (sortBy != null) {
      filteredContacts.sort((a, b) {
        int comparison;
        switch (sortBy) {
          case '姓名':
            comparison = a.name.compareTo(b.name);
            break;
          case '创建时间':
            comparison = a.createdAt.compareTo(b.createdAt);
            break;
          default:
            comparison = 0;
        }
        return ascending == true ? comparison : -comparison;
      });
    }

    return filteredContacts;
  }

  @override
  Future<bool> deleteContacts(List<String> ids) async {
    logger.d('删除联系人：$ids');
    try {
      for (final id in ids) {
        final index = _contacts.indexWhere((c) => c.id == id);
        if (index != -1) {
          _contacts[index] = _contacts[index].copyWith(isDeleted: true);
        }
      }
      return true;
    } catch (e) {
      logger.e('删除联系人失败: $e');
      return false;
    }
  }

  @override
  Future<ContactModel?> getContact(String id) async {
    logger.d('获取联系人：$id');
    try {
      return _contacts.firstWhere((c) => c.id == id && !c.isDeleted);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateContact(ContactModel contact) async {
    logger.d('更新联系人：${contact.id}');
    try {
      final index = _contacts.indexWhere((c) => c.id == contact.id);
      if (index != -1) {
        _contacts[index] = contact;
        return true;
      }
      return false;
    } catch (e) {
      logger.e('更新联系人失败: $e');
      return false;
    }
  }

  @override
  Future<List<ContactModel>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  }) async {
    logger.d('获取分类联系人：$category');
    var contacts =
        _contacts.where((c) => c.category == category && !c.isDeleted).toList();

    if (offset != null) {
      contacts = contacts.skip(offset).toList();
    }
    if (limit != null) {
      contacts = contacts.take(limit).toList();
    }

    return contacts;
  }

  @override
  Future<bool> updateContactCategory(
      String id, ContactCategory category) async {
    logger.d('更新联系人分类：$id, $category');
    try {
      final index = _contacts.indexWhere((c) => c.id == id);
      if (index != -1) {
        _contacts[index] = _contacts[index].copyWith(category: category);
        return true;
      }
      return false;
    } catch (e) {
      logger.e('更新联系人分类失败: $e');
      return false;
    }
  }

  @override
  Future<bool> updateContactProtectionStrategy(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  }) async {
    logger.d('更新联系人保护策略：$id, $strategy, $param');
    try {
      final index = _contacts.indexWhere((c) => c.id == id);
      if (index != -1) {
        _contacts[index] = _contacts[index].copyWith(
          protectionStrategy: strategy,
          protectionParam: param,
        );
        return true;
      }
      return false;
    } catch (e) {
      logger.e('更新联系人保护策略失败: $e');
      return false;
    }
  }

  @override
  Future<bool> batchUpdateCategory(
      List<String> ids, ContactCategory category) async {
    logger.d('批量更新联系人分类：$ids, $category');
    try {
      for (final id in ids) {
        final index = _contacts.indexWhere((c) => c.id == id);
        if (index != -1) {
          _contacts[index] = _contacts[index].copyWith(category: category);
        }
      }
      return true;
    } catch (e) {
      logger.e('批量更新联系人分类失败: $e');
      return false;
    }
  }

  @override
  Future<bool> batchUpdateProtectionStrategy(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  }) async {
    logger.d('批量更新联系人保护策略：$ids, $strategy, $param');
    try {
      for (final id in ids) {
        final index = _contacts.indexWhere((c) => c.id == id);
        if (index != -1) {
          _contacts[index] = _contacts[index].copyWith(
            protectionStrategy: strategy,
            protectionParam: param,
          );
        }
      }
      return true;
    } catch (e) {
      logger.e('批量更新联系人保护策略失败: $e');
      return false;
    }
  }

  @override
  Future<ContactModel?> findContactByPhoneNumber(String phoneNumber) async {
    logger.d('根据电话号码查找联系人：$phoneNumber');
    try {
      return _contacts.firstWhere(
        (c) => c.phoneNumber == phoneNumber && !c.isDeleted,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createTestData() async {
    logger.i('创建联系人测试数据');

    final now = DateTime.now();
    final testData = [
      ContactModel(
        id: '1',
        name: '张三',
        phoneNumber: '13800138000',
        category: ContactCategory.safe,
        protectionStrategy: ProtectionStrategy.permanent,
        createdAt: now.subtract(const Duration(days: 100)),
        updatedAt: now.subtract(const Duration(days: 1)),
        note: '重要客户',
      ),
      ContactModel(
        id: '2',
        name: '李四',
        phoneNumber: '13800138001',
        category: ContactCategory.temporary,
        protectionStrategy: ProtectionStrategy.time,
        protectionParam: '90', // 保存90天
        createdAt: now.subtract(const Duration(days: 50)),
        updatedAt: now.subtract(const Duration(days: 10)),
      ),
      ContactModel(
        id: '3',
        name: '王五',
        phoneNumber: '13800138002',
        category: ContactCategory.temporary,
        protectionStrategy: ProtectionStrategy.space,
        protectionParam: '104857600', // 保存100MB
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 5)),
      ),
      ContactModel(
        id: '4',
        name: '赵六',
        phoneNumber: '13800138003',
        category: ContactCategory.blacklist,
        protectionStrategy: ProtectionStrategy.none,
        createdAt: now.subtract(const Duration(days: 10)),
        updatedAt: now.subtract(const Duration(days: 10)),
        note: '骚扰电话',
      ),
      ContactModel(
        id: '5',
        name: '钱七',
        phoneNumber: '13800138004',
        category: ContactCategory.unclassified,
        protectionStrategy: ProtectionStrategy.none,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
      ),
    ];

    _contacts.addAll(testData);
    logger.i('创建了${testData.length}条测试数据');
  }
}
