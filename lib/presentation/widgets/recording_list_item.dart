import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/core/utils/app_utils.dart';
import 'package:recording_cleaner/presentation/widgets/animated_list_item.dart';
import 'package:recording_cleaner/presentation/widgets/audio_waveform.dart';

/// 录音文件列表项组件
class RecordingListItem extends StatelessWidget {
  /// 创建[RecordingListItem]实例
  const RecordingListItem({
    Key? key,
    required this.index,
    required this.title,
    required this.duration,
    required this.size,
    required this.samples,
    required this.onTap,
    this.subtitle,
    this.onDelete,
    this.onAction,
    this.actionLabel = '收藏',
    this.actionColor,
    this.isSelected = false,
    this.onSelectedChanged,
    this.showSlideAction = true,
  }) : super(key: key);

  /// 索引
  final int index;

  /// 标题
  final String title;

  /// 副标题
  final String? subtitle;

  /// 时长
  final Duration duration;

  /// 大小
  final int size;

  /// 波形数据
  final List<double> samples;

  /// 点击回调
  final VoidCallback onTap;

  /// 删除回调
  final Future<bool> Function()? onDelete;

  /// 操作回调
  final VoidCallback? onAction;

  /// 操作按钮文本
  final String actionLabel;

  /// 操作按钮颜色
  final Color? actionColor;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
                      ),
                    ],
                    SizedBox(height: 8.h),
                    AudioWaveform(
                      samples: samples,
                      height: 32,
                      width: double.infinity,
                      spacing: 2,
                      barWidth: 3,
                      color: colorScheme.primary.withOpacity(0.5),
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(0.5),
                          colorScheme.primary,
                        ],
                      ),
                      style: PaintingStyle.fill,
                      borderRadius: 2,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_rounded,
                          size: 16.w,
                          color: colorScheme.outline,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          AppUtils.formatDuration(duration),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                        ),
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.data_usage_rounded,
                          size: 16.w,
                          color: colorScheme.outline,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          AppUtils.formatFileSize(size),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                        ),
                      ],
                    ),
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
      onAction: onAction,
      actionLabel: actionLabel,
      actionColor: actionColor,
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
}
