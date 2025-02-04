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

/// 联系人实体类
class ContactEntity extends Equatable {
  /// 联系人的唯一标识符
  final String id;

  /// 联系人姓名
  final String name;

  /// 联系人电话号码
  final String phoneNumber;

  /// 联系人分类
  final ContactCategory category;

  /// 保护策略
  final ProtectionStrategy protectionStrategy;

  /// 保护策略参数（如保护时间或空间大小）
  final String? protectionParam;

  /// 备注信息
  final String? note;

  /// 创建时间
  final DateTime createdAt;

  /// 最后更新时间
  final DateTime updatedAt;

  /// 是否已被标记为删除
  final bool isDeleted;

  /// 是否受保护
  final bool isProtected;

  /// 创建一个[ContactEntity]实例
  ///
  /// 必需参数：
  /// - [id]：联系人的唯一标识符
  /// - [name]：联系人姓名
  /// - [phoneNumber]：联系人电话号码
  /// - [category]：联系人分类
  /// - [protectionStrategy]：保护策略
  /// - [createdAt]：创建时间
  /// - [updatedAt]：更新时间
  /// - [isProtected]：是否受保护
  ///
  /// 可选参数：
  /// - [protectionParam]：保护策略参数
  /// - [note]：备注信息
  /// - [isDeleted]：删除标记，默认为false
  const ContactEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.category = ContactCategory.none,
    this.isProtected = false,
    required this.protectionStrategy,
    required this.createdAt,
    required this.updatedAt,
    this.protectionParam,
    this.note,
    this.isDeleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        category,
        protectionStrategy,
        protectionParam,
        note,
        createdAt,
        updatedAt,
        isDeleted,
        isProtected,
      ];

  /// 复制新实例
  ContactEntity copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    ContactCategory? category,
    bool? isProtected,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      isProtected: isProtected ?? this.isProtected,
      protectionStrategy: this.protectionStrategy,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      protectionParam: this.protectionParam,
      note: this.note,
      isDeleted: this.isDeleted,
    );
  }
}
