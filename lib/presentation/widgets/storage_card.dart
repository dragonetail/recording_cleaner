/// 存储空间卡片组件
///
/// 显示设备存储空间的使用情况，包括：
/// - 总存储空间
/// - 已用空间
/// - 可用空间

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_utils.dart';

/// 存储卡片组件
class StorageCard extends StatelessWidget {
  /// 创建[StorageCard]实例
  const StorageCard({
    Key? key,
    required this.usedStorage,
    required this.totalStorage,
    this.onTap,
  }) : super(key: key);

  /// 已用存储空间
  final int usedStorage;

  /// 总存储空间
  final int totalStorage;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final usagePercent = totalStorage > 0 ? usedStorage / totalStorage : 0.0;
    final usedColor = AppUtils.getStorageStatusColor(context, usagePercent);

    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.storage_rounded,
                    color: usedColor,
                    size: 28.w,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    '存储空间',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              CircularPercentIndicator(
                radius: 100.w,
                lineWidth: 20.w,
                percent: usagePercent,
                backgroundColor: colorScheme.surfaceVariant,
                progressColor: usedColor,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: 1000,
                center: Container(
                  width: 140.w,
                  height: 140.w,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.1),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppUtils.formatPercentage(usagePercent),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: usedColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '已使用',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStorageText(
                    context,
                    label: '已用空间',
                    value: AppUtils.formatFileSize(usedStorage),
                    color: usedColor,
                  ),
                  Container(
                    height: 24.h,
                    width: 1,
                    color: colorScheme.outlineVariant,
                  ),
                  _buildStorageText(
                    context,
                    label: '总空间',
                    value: AppUtils.formatFileSize(totalStorage),
                    color: colorScheme.outline,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageText(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ],
    );
  }
}
