import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

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

/// 联系人列表项组件
class ContactListItem extends StatelessWidget {
  /// 创建[ContactListItem]实例
  const ContactListItem({
    Key? key,
    required this.index,
    required this.name,
    required this.phoneNumber,
    required this.category,
    required this.onTap,
    required this.onDelete,
    required this.onCategoryChanged,
    required this.onProtectionChanged,
    required this.isProtected,
    this.isSelected = false,
    this.onSelectedChanged,
    this.showSlideAction = true,
  }) : super(key: key);

  /// 列表项索引
  final int index;

  /// 联系人姓名
  final String name;

  /// 联系人电话号码
  final String phoneNumber;

  /// 联系人分类
  final ContactCategory category;

  /// 点击回调
  final VoidCallback onTap;

  /// 删除回调
  final Future<bool> Function() onDelete;

  /// 分类变更回调
  final ValueChanged<ContactCategory> onCategoryChanged;

  /// 保护状态变更回调
  final ValueChanged<bool> onProtectionChanged;

  /// 是否受保护
  final bool isProtected;

  /// 是否被选中
  final bool isSelected;

  /// 选中状态变更回调
  final ValueChanged<bool>? onSelectedChanged;

  /// 是否显示滑动操作
  final bool showSlideAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final content = ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.primary,
        child: Text(
          name.substring(0, 1),
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        phoneNumber,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isProtected)
            Icon(
              Icons.shield_rounded,
              size: 20.w,
              color: colorScheme.primary,
            ),
          SizedBox(width: 8.w),
          Icon(
            _getCategoryIcon(),
            size: 20.w,
            color: colorScheme.primary,
          ),
          if (onSelectedChanged != null) ...[
            SizedBox(width: 8.w),
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                onSelectedChanged?.call(value ?? false);
              },
            ),
          ],
        ],
      ),
      onTap: onSelectedChanged != null
          ? () => onSelectedChanged?.call(!isSelected)
          : onTap,
    );

    if (!showSlideAction) {
      return content;
    }

    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            onDelete();
          },
        ),
        children: [
          SlidableAction(
            onPressed: (_) {
              onDelete();
            },
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            icon: Icons.delete_rounded,
            label: '删除',
          ),
          SlidableAction(
            onPressed: (_) {
              onProtectionChanged(!isProtected);
            },
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            icon: isProtected ? Icons.shield_rounded : Icons.shield_outlined,
            label: isProtected ? '取消保护' : '保护',
          ),
          SlidableAction(
            onPressed: (_) {
              _showCategoryDialog(context);
            },
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            icon: Icons.category_rounded,
            label: '分类',
          ),
        ],
      ),
      child: content,
    );
  }

  /// 获取分类图标
  IconData _getCategoryIcon() {
    switch (category) {
      case ContactCategory.family:
        return Icons.family_restroom_rounded;
      case ContactCategory.friend:
        return Icons.people_rounded;
      case ContactCategory.colleague:
        return Icons.work_rounded;
      case ContactCategory.customer:
        return Icons.business_rounded;
      case ContactCategory.other:
        return Icons.category_rounded;
      case ContactCategory.none:
        return Icons.help_outline_rounded;
    }
  }

  /// 显示分类选择对话框
  Future<void> _showCategoryDialog(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final result = await showDialog<ContactCategory>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('选择分类'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.family_restroom_rounded,
                  color: colorScheme.primary,
                ),
                title: const Text('家人'),
                onTap: () {
                  Navigator.of(context).pop(ContactCategory.family);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.people_rounded,
                  color: colorScheme.primary,
                ),
                title: const Text('朋友'),
                onTap: () {
                  Navigator.of(context).pop(ContactCategory.friend);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.work_rounded,
                  color: colorScheme.primary,
                ),
                title: const Text('同事'),
                onTap: () {
                  Navigator.of(context).pop(ContactCategory.colleague);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.business_rounded,
                  color: colorScheme.primary,
                ),
                title: const Text('客户'),
                onTap: () {
                  Navigator.of(context).pop(ContactCategory.customer);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.category_rounded,
                  color: colorScheme.primary,
                ),
                title: const Text('其他'),
                onTap: () {
                  Navigator.of(context).pop(ContactCategory.other);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline_rounded,
                  color: colorScheme.primary,
                ),
                title: const Text('未分类'),
                onTap: () {
                  Navigator.of(context).pop(ContactCategory.none);
                },
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      onCategoryChanged(result);
    }
  }
}
