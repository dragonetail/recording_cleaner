import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/presentation/widgets/animated_list_item.dart';

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
    this.isProtected = false,
    this.onDelete,
    this.onCategoryChanged,
    this.onProtectionChanged,
    this.isSelected = false,
    this.onSelectedChanged,
    this.showSlideAction = true,
  }) : super(key: key);

  /// 索引
  final int index;

  /// 联系人姓名
  final String name;

  /// 电话号码
  final String phoneNumber;

  /// 分类
  final ContactCategory category;

  /// 点击回调
  final VoidCallback onTap;

  /// 是否受保护
  final bool isProtected;

  /// 删除回调
  final Future<bool> Function()? onDelete;

  /// 分类变更回调
  final ValueChanged<ContactCategory>? onCategoryChanged;

  /// 保护状态变更回调
  final ValueChanged<bool>? onProtectionChanged;

  /// 是否选中
  final bool isSelected;

  /// 选中状态变更回调
  final ValueChanged<bool>? onSelectedChanged;

  /// 是否显示滑动操作
  final bool showSlideAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget content = Material(
      color: colorScheme.surface,
      child: InkWell(
        onTap: onSelectedChanged != null
            ? () => onSelectedChanged!(!isSelected)
            : onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          child: Row(
            children: [
              if (onSelectedChanged != null) ...[
                Checkbox(
                  value: isSelected,
                  onChanged: (value) => onSelectedChanged!(value ?? false),
                ),
                SizedBox(width: 8.w),
              ],
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    name.characters.first,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        if (isProtected)
                          Icon(
                            Icons.shield_rounded,
                            size: 20.w,
                            color: colorScheme.primary,
                          ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      phoneNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.outline,
                          ),
                    ),
                    if (category != ContactCategory.none) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          _getCategoryText(category),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (onSelectedChanged != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: content,
        ),
      );
    }

    return AnimatedListItem(
      index: index,
      onDelete: onDelete,
      onAction: onProtectionChanged != null
          ? () => onProtectionChanged!(!isProtected)
          : null,
      actionLabel: isProtected ? '取消保护' : '设置保护',
      actionColor: colorScheme.secondary,
      showSlideAction: showSlideAction,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: content,
        ),
      ),
    );
  }

  String _getCategoryText(ContactCategory category) {
    switch (category) {
      case ContactCategory.family:
        return '家人';
      case ContactCategory.friend:
        return '朋友';
      case ContactCategory.colleague:
        return '同事';
      case ContactCategory.other:
        return '其他';
      default:
        return '';
    }
  }
}
