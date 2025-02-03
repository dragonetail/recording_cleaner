import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_utils.dart';

/// 列表项动画组件
class AnimatedListItem extends StatelessWidget {
  /// 创建[AnimatedListItem]实例
  const AnimatedListItem({
    Key? key,
    required this.index,
    required this.child,
    this.onDelete,
    this.onAction,
    this.deleteLabel = '删除',
    this.actionLabel = '操作',
    this.actionColor,
    this.showSlideAction = true,
  }) : super(key: key);

  /// 索引
  final int index;

  /// 子组件
  final Widget child;

  /// 删除回调
  final Future<bool> Function()? onDelete;

  /// 操作回调
  final VoidCallback? onAction;

  /// 删除按钮文本
  final String deleteLabel;

  /// 操作按钮文本
  final String actionLabel;

  /// 操作按钮颜色
  final Color? actionColor;

  /// 是否显示滑动操作
  final bool showSlideAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget content = AnimationConfiguration.staggeredList(
      position: index,
      duration: AppConstants.listItemAnimationDuration,
      delay: AppConstants.listAnimationDelay,
      child: SlideAnimation(
        verticalOffset: 50.h,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );

    if (!showSlideAction) return content;

    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: onDelete != null
            ? DismissiblePane(
                onDismissed: () {},
                confirmDismiss: () async {
                  final confirmed = await AppUtils.showConfirmDialog(
                    context,
                    title: '确认删除',
                    content: '确定要删除该项吗？',
                  );
                  if (confirmed) {
                    final success = await onDelete!();
                    if (success) {
                      AppUtils.vibrate();
                      AppUtils.showSnackBar(context, '删除成功');
                    } else {
                      AppUtils.showSnackBar(context, '删除失败', isError: true);
                    }
                    return success;
                  }
                  return false;
                },
              )
            : null,
        children: [
          if (onDelete != null)
            SlidableAction(
              onPressed: (_) async {
                final confirmed = await AppUtils.showConfirmDialog(
                  context,
                  title: '确认删除',
                  content: '确定要删除该项吗？',
                );
                if (confirmed) {
                  final success = await onDelete!();
                  if (success) {
                    AppUtils.vibrate();
                    AppUtils.showSnackBar(context, '删除成功');
                  } else {
                    AppUtils.showSnackBar(context, '删除失败', isError: true);
                  }
                }
              },
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              icon: Icons.delete_rounded,
              label: deleteLabel,
            ),
        ],
      ),
      startActionPane: onAction != null
          ? ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    onAction!();
                    AppUtils.vibrate();
                  },
                  backgroundColor: actionColor ?? colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  icon: Icons.star_rounded,
                  label: actionLabel,
                ),
              ],
            )
          : null,
      child: content,
    );
  }
}
