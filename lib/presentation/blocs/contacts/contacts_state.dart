import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 联系人列表状态
class ContactsState extends Equatable {
  /// 创建[ContactsState]实例
  const ContactsState({
    this.contacts = const [],
    this.selectedContacts = const [],
    this.isLoading = false,
    this.isSelectionMode = false,
    this.error,
  });

  /// 联系人列表
  final List<ContactEntity> contacts;

  /// 已选择的联系人ID列表
  final List<String> selectedContacts;

  /// 是否正在加载
  final bool isLoading;

  /// 是否处于选择模式
  final bool isSelectionMode;

  /// 错误信息
  final String? error;

  /// 初始状态
  factory ContactsState.initial() {
    return const ContactsState();
  }

  /// 复制新实例
  ContactsState copyWith({
    List<ContactEntity>? contacts,
    List<String>? selectedContacts,
    bool? isLoading,
    bool? isSelectionMode,
    String? error,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      selectedContacts: selectedContacts ?? this.selectedContacts,
      isLoading: isLoading ?? this.isLoading,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        contacts,
        selectedContacts,
        isLoading,
        isSelectionMode,
        error,
      ];
}
