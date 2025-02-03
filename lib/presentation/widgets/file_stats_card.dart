/// 文件统计卡片组件
///
/// 显示文件统计信息，包括：
/// - 总文件数和大小
/// - 重要文件数和大小
/// - 可清理文件数和大小

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:recording_cleaner/core/utils/app_utils.dart';

/// 文件统计卡片组件
class FileStatsCard extends StatelessWidget {
  /// 创建[FileStatsCard]实例
  const FileStatsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.duration,
    required this.size,
    required this.totalSize,
    this.color,
    this.onTap,
  }) : super(key: key);

  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 文件数量
  final int count;

  /// 总时长
  final Duration duration;

  /// 总大小
  final int size;

  /// 总存储空间
  final int totalSize;

  /// 颜色
  final Color? color;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sizePercent = totalSize > 0 ? size / totalSize : 0.0;
    final cardColor = color ?? colorScheme.primary;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: cardColor,
                    size: 24.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CircularPercentIndicator(
                radius: 70.w,
                lineWidth: 12.w,
                percent: sizePercent,
                backgroundColor: colorScheme.surfaceVariant,
                progressColor: cardColor,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: 1000,
                center: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.1),
                        blurRadius: 6.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        count.toString(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: cardColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '文件',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    _buildStatItem(
                      context,
                      icon: Icons.timer_rounded,
                      label: '总时长',
                      value: AppUtils.formatDuration(duration),
                      color: cardColor,
                    ),
                    SizedBox(height: 8.h),
                    _buildStatItem(
                      context,
                      icon: Icons.data_usage_rounded,
                      label: '总大小',
                      value: AppUtils.formatFileSize(size),
                      color: cardColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.w,
          color: color.withOpacity(0.8),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
