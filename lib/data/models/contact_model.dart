/// 联系人数据模型
///
/// 继承自[ContactEntity]，用于数据层的联系人数据处理。
/// 提供JSON序列化和反序列化功能。

import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 联系人数据模型
class ContactModel extends ContactEntity {
  /// 创建一个[ContactModel]实例
  const ContactModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.category,
    required super.protectionStrategy,
    required super.createdAt,
    required super.updatedAt,
    super.protectionParam,
    super.note,
    super.isDeleted,
  });

  /// 从JSON映射创建[ContactModel]实例
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      category: ContactCategory.values[json['category'] as int],
      protectionStrategy:
          ProtectionStrategy.values[json['protectionStrategy'] as int],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      protectionParam: json['protectionParam'] as String?,
      note: json['note'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  /// 将[ContactModel]转换为JSON映射
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'category': category.index,
      'protectionStrategy': protectionStrategy.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'protectionParam': protectionParam,
      'note': note,
      'isDeleted': isDeleted,
    };
  }

  /// 从实体创建模型实例
  factory ContactModel.fromEntity(ContactEntity entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      category: entity.category,
      protectionStrategy: entity.protectionStrategy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      protectionParam: entity.protectionParam,
      note: entity.note,
      isDeleted: entity.isDeleted,
    );
  }

  /// 创建一个具有新属性的[ContactModel]实例
  ContactModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    ContactCategory? category,
    ProtectionStrategy? protectionStrategy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? protectionParam,
    String? note,
    bool? isDeleted,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      protectionStrategy: protectionStrategy ?? this.protectionStrategy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      protectionParam: protectionParam ?? this.protectionParam,
      note: note ?? this.note,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
