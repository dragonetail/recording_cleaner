/// 联系人数据模型
///
/// 继承自[ContactEntity]，用于数据层的联系人数据处理。
/// 提供JSON序列化和反序列化功能。

import 'package:isar/isar.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

part 'contact_model.g.dart';

/// 联系人数据模型
@collection
class ContactModel {
  /// 创建[ContactModel]实例
  ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.category = ContactCategory.none,
    this.isProtected = false,
  });

  /// 联系人ID
  @Id()
  final String id;

  /// 联系人姓名
  final String name;

  /// 联系人电话号码
  final String phoneNumber;

  /// 联系人分类
  @enumerated
  final ContactCategory category;

  /// 是否受保护
  final bool isProtected;

  /// 从实体转换为数据模型
  factory ContactModel.fromEntity(ContactEntity entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      category: entity.category,
      isProtected: entity.isProtected,
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
    );
  }

  /// 复制新实例
  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    ContactCategory? category,
    bool? isProtected,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      isProtected: isProtected ?? this.isProtected,
    );
  }
}
