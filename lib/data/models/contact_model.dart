/// 联系人数据模型
///
/// 继承自[ContactEntity]，用于数据层的联系人数据处理。
/// 提供JSON序列化和反序列化功能。

import 'package:isar/isar.dart';
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
  });

  /// 联系人ID
  Id get isarId => fastHash(id);

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

  /// 计算字符串的哈希值
  int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
