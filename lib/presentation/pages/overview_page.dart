/// 概览页面
///
/// 显示应用的整体概览信息，包括：
/// - 存储空间使用情况
/// - 录音文件统计
/// - 通话录音统计
/// - 快捷操作入口

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 概览页面
class OverviewPage extends StatelessWidget {
  /// 创建[OverviewPage]实例
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('概览'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: 实现设置功能
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildStorageCard(theme),
          SizedBox(height: 16.h),
          _buildRecentRecordingsCard(theme),
          SizedBox(height: 16.h),
          _buildRecentCallsCard(theme),
        ],
      ),
    );
  }

  Widget _buildStorageCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '存储空间',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 16.h),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: theme.colorScheme.surfaceVariant,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '已使用: 70%',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  '剩余: 30%',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRecordingsCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '最近录音',
                  style: theme.textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: 跳转到录音列表
                  },
                  child: const Text('查看全部'),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.mic),
                  title: Text('录音 ${index + 1}'),
                  subtitle: Text('2024-03-${10 + index} 10:00'),
                  trailing: Text('${5 + index}分钟'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCallsCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '最近通话',
                  style: theme.textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: 跳转到通话列表
                  },
                  child: const Text('查看全部'),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text('联系人 ${index + 1}'),
                  subtitle: Text('2024-03-${10 + index} 11:00'),
                  trailing: Text('${3 + index}分钟'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
