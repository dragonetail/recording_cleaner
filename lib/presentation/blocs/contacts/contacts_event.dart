import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 联系人列表事件
abstract class ContactsEvent extends Equatable {
  /// 创建[ContactsEvent]实例
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

/// 加载联系人列表事件
class LoadContacts extends ContactsEvent {
  /// 创建[LoadContacts]实例
  const LoadContacts();
}

/// 删除联系人事件
class DeleteContacts extends ContactsEvent {
  /// 创建[DeleteContacts]实例
  const DeleteContacts(this.ids);

  /// 要删除的联系人ID列表
  final List<String> ids;

  @override
  List<Object?> get props => [ids];
}

/// 删除选中的联系人事件
class DeleteSelectedContacts extends ContactsEvent {
  /// 创建[DeleteSelectedContacts]实例
  const DeleteSelectedContacts();
}

/// 进入选择模式事件
class EnterSelectionMode extends ContactsEvent {
  /// 创建[EnterSelectionMode]实例
  const EnterSelectionMode();
}

/// 退出选择模式事件
class ExitSelectionMode extends ContactsEvent {
  /// 创建[ExitSelectionMode]实例
  const ExitSelectionMode();
}

/// 切换联系人选择状态事件
class ToggleContactSelection extends ContactsEvent {
  /// 创建[ToggleContactSelection]实例
  const ToggleContactSelection(this.id);

  /// 联系人ID
  final String id;

  @override
  List<Object?> get props => [id];
}

/// 切换全选状态事件
class ToggleSelectAll extends ContactsEvent {
  /// 创建[ToggleSelectAll]实例
  const ToggleSelectAll();
}

/// 更新联系人分类事件
class UpdateContactCategory extends ContactsEvent {
  /// 创建[UpdateContactCategory]实例
  const UpdateContactCategory(this.id, this.category);

  /// 联系人ID
  final String id;

  /// 新的分类
  final ContactCategory category;

  @override
  List<Object?> get props => [id, category];
}

/// 更新联系人保护状态事件
class UpdateContactProtection extends ContactsEvent {
  /// 创建[UpdateContactProtection]实例
  const UpdateContactProtection(this.id, this.isProtected);

  /// 联系人ID
  final String id;

  /// 是否受保护
  final bool isProtected;

  @override
  List<Object?> get props => [id, isProtected];
}
