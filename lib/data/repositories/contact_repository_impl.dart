/// 联系人仓库实现
///
/// 实现[ContactRepository]接口，使用[ContactSource]作为数据源。

import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/data/models/contact_model.dart';
import 'package:recording_cleaner/data/sources/contact_source.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';

/// 联系人仓库实现
class ContactRepositoryImpl implements ContactRepository {
  /// 创建[ContactRepositoryImpl]实例
  ContactRepositoryImpl({
    required AppLogger logger,
    required ContactSource contactSource,
  })  : _logger = logger,
        _contactSource = contactSource;

  final AppLogger _logger;
  final ContactSource _contactSource;

  @override
  Future<List<ContactEntity>> getContacts() async {
    try {
      final contacts = await _contactSource.getContacts();
      return contacts.map((e) => e.toEntity()).toList();
    } catch (e, s) {
      _logger.e('获取联系人列表失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteContacts(List<String> ids) async {
    try {
      await _contactSource.deleteContacts(ids);
    } catch (e, s) {
      _logger.e('删除联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<ContactEntity?> getContact(String id) async {
    try {
      final contact = await _contactSource.getContact(id);
      return contact?.toEntity();
    } catch (e, s) {
      _logger.e('获取联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> updateContact(ContactEntity contact) async {
    try {
      await _contactSource.updateContact(ContactModel.fromEntity(contact));
    } catch (e, s) {
      _logger.e('更新联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ContactEntity>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  }) async {
    try {
      final contacts = await _contactSource.getContactsByCategory(
        category,
        limit: limit,
        offset: offset,
      );
      return contacts.map((e) => e.toEntity()).toList();
    } catch (e, s) {
      _logger.e('获取指定分类的联系人列表失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> updateContactCategory(
      String id, ContactCategory category) async {
    try {
      await _contactSource.updateContactCategory(id, category);
    } catch (e, s) {
      _logger.e('更新联系人分类失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> updateContactProtection(String id, bool isProtected) async {
    try {
      await _contactSource.updateContactProtection(id, isProtected);
    } catch (e, s) {
      _logger.e('更新联系人保护状态失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> updateContactProtectionStrategy(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    return _contactSource.updateContactProtectionStrategy(
      id,
      strategy,
      param: param,
    );
  }

  @override
  Future<bool> batchUpdateCategory(List<String> ids, ContactCategory category) {
    return _contactSource.batchUpdateCategory(ids, category);
  }

  @override
  Future<bool> batchUpdateProtectionStrategy(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    return _contactSource.batchUpdateProtectionStrategy(
      ids,
      strategy,
      param: param,
    );
  }

  @override
  Future<ContactEntity?> findContactByPhoneNumber(String phoneNumber) async {
    try {
      final contact =
          await _contactSource.findContactByPhoneNumber(phoneNumber);
      return contact?.toEntity();
    } catch (e, s) {
      _logger.e('根据电话号码查找联系人失败', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> createTestData() async {
    try {
      await _contactSource.createTestData();
    } catch (e, s) {
      _logger.e('创建测试数据失败', error: e, stackTrace: s);
      rethrow;
    }
  }
}
