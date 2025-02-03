import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_utils.dart';

/// 选择模式组件
class SelectionMode extends StatelessWidget {
  /// 创建[SelectionMode]实例
  const SelectionMode({
    Key? key,
    required this.selectedCount,
    required this.onSelectAll,
    required this.onDelete,
    required this.onCancel,
    this.totalCount = 0,
    this.onShare,
  }) : super(key: key);

  /// 已选择数量
  final int selectedCount;

  /// 总数量
  final int totalCount;

  /// 全选回调
  final VoidCallback onSelectAll;

  /// 删除回调
  final Future<bool> Function() onDelete;

  /// 分享回调
  final VoidCallback? onShare;

  /// 取消回调
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            TextButton.icon(
              onPressed: onSelectAll,
              icon: Icon(
                selectedCount == totalCount
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selectedCount == totalCount
                    ? colorScheme.primary
                    : colorScheme.outline,
              ),
              label: Text(
                selectedCount == totalCount ? '取消全选' : '全选',
                style: TextStyle(
                  color: selectedCount == totalCount
                      ? colorScheme.primary
                      : colorScheme.outline,
                ),
              ),
            ),
            const Spacer(),
            if (onShare != null)
              IconButton(
                onPressed: selectedCount > 0 ? onShare : null,
                icon: Icon(
                  Icons.share_rounded,
                  color: selectedCount > 0
                      ? colorScheme.primary
                      : colorScheme.outline,
                ),
              ),
            IconButton(
              onPressed: selectedCount > 0
                  ? () async {
                      final confirmed = await AppUtils.showConfirmDialog(
                        context,
                        title: '确认删除',
                        content: '确定要删除选中的 $selectedCount 项吗？',
                      );
                      if (confirmed) {
                        final success = await onDelete();
                        if (success) {
                          AppUtils.vibrate();
                          AppUtils.showSnackBar(context, '删除成功');
                        } else {
                          AppUtils.showSnackBar(context, '删除失败', isError: true);
                        }
                      }
                    }
                  : null,
              icon: Icon(
                Icons.delete_rounded,
                color:
                    selectedCount > 0 ? colorScheme.error : colorScheme.outline,
              ),
            ),
            IconButton(
              onPressed: onCancel,
              icon: Icon(
                Icons.close_rounded,
                color: colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 选择模式头部组件
class SelectionModeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// 创建[SelectionModeAppBar]实例
  const SelectionModeAppBar({
    Key? key,
    required this.selectedCount,
    required this.onSelectAll,
    required this.onDelete,
    required this.onCancel,
    this.totalCount = 0,
    this.onShare,
  }) : super(key: key);

  /// 已选择数量
  final int selectedCount;

  /// 总数量
  final int totalCount;

  /// 全选回调
  final VoidCallback onSelectAll;

  /// 删除回调
  final Future<bool> Function() onDelete;

  /// 分享回调
  final VoidCallback? onShare;

  /// 取消回调
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      leading: IconButton(
        onPressed: onCancel,
        icon: const Icon(Icons.close_rounded),
      ),
      title: Text('已选择 $selectedCount 项'),
      actions: [
        TextButton.icon(
          onPressed: onSelectAll,
          icon: Icon(
            selectedCount == totalCount
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: selectedCount == totalCount
                ? colorScheme.primary
                : colorScheme.outline,
          ),
          label: Text(
            selectedCount == totalCount ? '取消全选' : '全选',
            style: TextStyle(
              color: selectedCount == totalCount
                  ? colorScheme.primary
                  : colorScheme.outline,
            ),
          ),
        ),
        if (onShare != null)
          IconButton(
            onPressed: selectedCount > 0 ? onShare : null,
            icon: Icon(
              Icons.share_rounded,
              color:
                  selectedCount > 0 ? colorScheme.primary : colorScheme.outline,
            ),
          ),
        IconButton(
          onPressed: selectedCount > 0
              ? () async {
                  final confirmed = await AppUtils.showConfirmDialog(
                    context,
                    title: '确认删除',
                    content: '确定要删除选中的 $selectedCount 项吗？',
                  );
                  if (confirmed) {
                    final success = await onDelete();
                    if (success) {
                      AppUtils.vibrate();
                      AppUtils.showSnackBar(context, '删除成功');
                    } else {
                      AppUtils.showSnackBar(context, '删除失败', isError: true);
                    }
                  }
                }
              : null,
          icon: Icon(
            Icons.delete_rounded,
            color: selectedCount > 0 ? colorScheme.error : colorScheme.outline,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
