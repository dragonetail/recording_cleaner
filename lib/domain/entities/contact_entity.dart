/// 联系人实体类
///
/// 定义了联系人的基本属性和行为。
/// 继承自[Equatable]以支持值相等性比较。
///
/// {@template contact_entity}
/// 包含联系人的以下属性：
/// - 唯一标识符
/// - 姓名
/// - 电话号码
/// - 联系人分类
/// - 保护策略
/// - 创建和更新时间
/// - 删除标记
/// {@endtemplate}

import 'package:equatable/equatable.dart';

/// 联系人分类
enum ContactCategory {
  /// 未分类
  none,

  /// 家人
  family,

  /// 朋友
  friend,

  /// 同事
  colleague,

  /// 客户
  customer,

  /// 其他
  other,
}

/// 联系人保护策略枚举
enum ProtectionStrategy {
  /// 永久保护：永不删除
  permanent,

  /// 时间保护：保存指定时间
  time,

  /// 空间保护：保存到指定大小
  space,

  /// 无保护：随时可删除
  none,
}

/// 联系人实体
class ContactEntity extends Equatable {
  /// 创建[ContactEntity]实例
  const ContactEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.category = ContactCategory.none,
    this.isProtected = false,
    this.createdAt,
    this.updatedAt,
    this.protectionParam,
    this.note,
    this.isDeleted = false,
  });

  /// 联系人ID
  final String id;

  /// 联系人姓名
  final String name;

  /// 联系人电话号码
  final String phoneNumber;

  /// 联系人分类
  final ContactCategory category;

  /// 是否受保护
  final bool isProtected;

  /// 创建时间
  final DateTime? createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  /// 保护策略参数（如保护时间或空间大小）
  final String? protectionParam;

  /// 备注信息
  final String? note;

  /// 是否已被标记为删除
  final bool isDeleted;

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        category,
        isProtected,
        createdAt,
        updatedAt,
        protectionParam,
        note,
        isDeleted,
      ];

  /// 复制新实例
  ContactEntity copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    ContactCategory? category,
    bool? isProtected,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? protectionParam,
    String? note,
    bool? isDeleted,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      isProtected: isProtected ?? this.isProtected,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      protectionParam: protectionParam ?? this.protectionParam,
      note: note ?? this.note,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
