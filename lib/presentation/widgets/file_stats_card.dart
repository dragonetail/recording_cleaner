/// 文件统计卡片组件
///
/// 显示文件统计信息，包括：
/// - 总文件数和大小
/// - 重要文件数和大小
/// - 可清理文件数和大小

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_state.dart';

/// 文件统计卡片组件
class FileStatsCard extends StatelessWidget {
  /// 卡片标题
  final String title;

  /// 图标
  final IconData icon;

  /// 文件统计信息
  final FileStats stats;

  /// 清理按钮点击回调
  final VoidCallback onClean;

  /// 创建[FileStatsCard]实例
  const FileStatsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.stats,
    required this.onClean,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  icon,
                  color: colorScheme.primary,
                  size: 24.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // 文件统计信息
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFileStats(
                  context,
                  label: '总计',
                  count: stats.totalCount,
                  size: stats.totalSize,
                  color: colorScheme.primary,
                ),
                _buildFileStats(
                  context,
                  label: '重要',
                  count: stats.importantCount,
                  size: stats.importantSize,
                  color: colorScheme.secondary,
                ),
                _buildFileStats(
                  context,
                  label: '可清理',
                  count: stats.cleanableCount,
                  size: stats.cleanableSize,
                  color: colorScheme.error,
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // 清理按钮
            if (stats.cleanableCount > 0)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onClean,
                  icon: const Icon(Icons.cleaning_services),
                  label: Text('清理 ${_formatSize(stats.cleanableSize)}'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 构建文件统计信息项
  Widget _buildFileStats(
    BuildContext context, {
    required String label,
    required int count,
    required int size,
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
          '$count个',
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          _formatSize(size),
          style: theme.textTheme.bodySmall?.copyWith(
            color: color,
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
