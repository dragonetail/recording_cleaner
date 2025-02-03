/// 联系人仓库实现
///
/// 实现[ContactRepository]接口，使用[ContactSource]作为数据源。

import 'package:recording_cleaner/data/models/contact_model.dart';
import 'package:recording_cleaner/data/sources/contact_source.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';

/// 联系人仓库实现
class ContactRepositoryImpl implements ContactRepository {
  /// 联系人数据源
  final ContactSource _source;

  /// 创建[ContactRepositoryImpl]实例
  ContactRepositoryImpl(this._source);

  @override
  Future<List<ContactEntity>> getContacts({
    ContactCategory? category,
    ProtectionStrategy? protectionStrategy,
    String? searchText,
    String? sortBy,
    bool? ascending,
  }) {
    return _source.getContacts(
      category: category,
      protectionStrategy: protectionStrategy,
      searchText: searchText,
      sortBy: sortBy,
      ascending: ascending,
    );
  }

  @override
  Future<bool> deleteContacts(List<String> ids) {
    return _source.deleteContacts(ids);
  }

  @override
  Future<ContactEntity?> getContact(String id) {
    return _source.getContact(id);
  }

  @override
  Future<bool> updateContact(ContactEntity contact) {
    if (contact is ContactModel) {
      return _source.updateContact(contact);
    }
    return _source.updateContact(ContactModel.fromEntity(contact));
  }

  @override
  Future<List<ContactEntity>> getContactsByCategory(
    ContactCategory category, {
    int? limit,
    int? offset,
  }) {
    return _source.getContactsByCategory(
      category,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<bool> updateContactCategory(String id, ContactCategory category) {
    return _source.updateContactCategory(id, category);
  }

  @override
  Future<bool> updateContactProtectionStrategy(
    String id,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    return _source.updateContactProtectionStrategy(
      id,
      strategy,
      param: param,
    );
  }

  @override
  Future<bool> batchUpdateCategory(List<String> ids, ContactCategory category) {
    return _source.batchUpdateCategory(ids, category);
  }

  @override
  Future<bool> batchUpdateProtectionStrategy(
    List<String> ids,
    ProtectionStrategy strategy, {
    String? param,
  }) {
    return _source.batchUpdateProtectionStrategy(
      ids,
      strategy,
      param: param,
    );
  }

  @override
  Future<ContactEntity?> findContactByPhoneNumber(String phoneNumber) {
    return _source.findContactByPhoneNumber(phoneNumber);
  }
}
