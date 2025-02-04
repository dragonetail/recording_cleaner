/// 联系人数据模型
///
/// 继承自[ContactEntity]，用于数据层的联系人数据处理。
/// 提供JSON序列化和反序列化功能。

import 'package:isar/isar.dart';
import 'package:recording_cleaner/core/utils/hash_utils.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

part 'contact_model.g.dart';

/// 联系人数据模型
@Collection()
class ContactModel {
  /// 创建[ContactModel]实例
  ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.category = ContactCategory.none,
    this.isProtected = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 联系人ID
  Id get isarId => HashUtils.fastHash(id);

  /// 联系人ID
  @Index(unique: true, replace: true)
  final String id;

  /// 联系人姓名
  @Index(type: IndexType.value)
  final String name;

  /// 联系人电话号码
  @Index(unique: true, replace: true)
  final String phoneNumber;

  /// 联系人分类
  @enumerated
  final ContactCategory category;

  /// 是否受保护
  final bool isProtected;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;

  /// 从实体转换为数据模型
  factory ContactModel.fromEntity(ContactEntity entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      category: entity.category,
      isProtected: entity.isProtected,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// 转换为实体
  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      category: category,
      isProtected: isProtected,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 复制新实例
  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    ContactCategory? category,
    bool? isProtected,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      isProtected: isProtected ?? this.isProtected,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
