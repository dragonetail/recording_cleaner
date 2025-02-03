/// 存储空间卡片组件
///
/// 显示设备存储空间的使用情况，包括：
/// - 总存储空间
/// - 已用空间
/// - 可用空间

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_state.dart';

/// 存储空间卡片组件
class StorageCard extends StatelessWidget {
  /// 存储空间统计信息
  final StorageStats stats;

  /// 创建[StorageCard]实例
  const StorageCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 计算已用空间百分比
    final usedPercent = stats.usedSpace / stats.totalSpace;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Row(
              children: [
                Icon(
                  Icons.storage,
                  color: colorScheme.primary,
                  size: 24.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  '存储空间',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // 进度条
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: usedPercent,
                backgroundColor: colorScheme.surfaceVariant,
                minHeight: 8.h,
              ),
            ),
            SizedBox(height: 16.h),

            // 详细信息
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStorageInfo(
                  context,
                  label: '总空间',
                  value: _formatSize(stats.totalSpace),
                  color: colorScheme.primary,
                ),
                _buildStorageInfo(
                  context,
                  label: '已用空间',
                  value: _formatSize(stats.usedSpace),
                  color: colorScheme.error,
                ),
                _buildStorageInfo(
                  context,
                  label: '可用空间',
                  value: _formatSize(stats.freeSpace),
                  color: colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建存储信息项
  Widget _buildStorageInfo(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// 格式化文件大小
  String _formatSize(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = bytes.toDouble();
    var unit = 0;

    while (size >= 1024 && unit < units.length - 1) {
      size /= 1024;
      unit++;
    }

    return '${size.toStringAsFixed(2)} ${units[unit]}';
  }
}
