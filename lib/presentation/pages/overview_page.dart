/// 概览页面
///
/// 显示应用的整体概览信息，包括：
/// - 存储空间使用情况
/// - 录音文件统计
/// - 通话录音统计
/// - 快捷操作入口

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_event.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_state.dart';

/// 概览页面
class OverviewPage extends StatelessWidget {
  /// 创建[OverviewPage]实例
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewBloc(
        logger: appLogger,
        recordingRepository: context.read(),
        callRecordingRepository: context.read(),
      )..add(const LoadOverviewData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('录音空间清理'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<OverviewBloc>().add(const RefreshOverviewData());
              },
            ),
          ],
        ),
        body: BlocBuilder<OverviewBloc, OverviewState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('加载失败：${state.error}'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<OverviewBloc>().add(const RefreshOverviewData());
              },
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _buildStorageSection(context, state),
                  SizedBox(height: 16.h),
                  _buildStatsSection(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStorageSection(BuildContext context, OverviewState state) {
    final colorScheme = Theme.of(context).colorScheme;
    final usedPercent = (state.storageUsage * 100).toStringAsFixed(1);
    final usedColor = state.storageUsage > 0.9
        ? colorScheme.error
        : state.storageUsage > 0.7
            ? colorScheme.tertiary
            : colorScheme.primary;

    return Card(
      elevation: 2,
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
              percent: state.storageUsage,
              backgroundColor: colorScheme.surfaceVariant,
              progressColor: usedColor,
              circularStrokeCap: CircularStrokeCap.round,
              center: Container(
                width: 140.w,
                height: 140.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$usedPercent%',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  value: _formatFileSize(state.usedStorage),
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
                  value: _formatFileSize(state.totalStorage),
                  color: colorScheme.outline,
                ),
              ],
            ),
          ],
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

  Widget _buildStatsSection(BuildContext context, OverviewState state) {
    return Row(
      children: [
        Expanded(
          child: _buildStatsCard(
            context,
            icon: Icons.mic_rounded,
            title: '录音文件',
            count: state.recordingsCount,
            duration: state.recordingsDuration,
            size: state.recordingsSize,
            totalSize: state.usedStorage,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildStatsCard(
            context,
            icon: Icons.call_rounded,
            title: '通话录音',
            count: state.callRecordingsCount,
            duration: state.callRecordingsDuration,
            size: state.callRecordingsSize,
            totalSize: state.usedStorage,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int count,
    required Duration duration,
    required int size,
    required int totalSize,
    required Color color,
  }) {
    final sizePercent = totalSize > 0 ? size / totalSize : 0.0;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
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
              progressColor: color,
              circularStrokeCap: CircularStrokeCap.round,
              center: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.1),
                      blurRadius: 6,
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
                            color: color,
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
                    value: _formatDuration(duration),
                    color: color,
                  ),
                  SizedBox(height: 8.h),
                  _buildStatItem(
                    context,
                    icon: Icons.data_usage_rounded,
                    label: '总大小',
                    value: _formatFileSize(size),
                    color: color,
                  ),
                ],
              ),
            ),
          ],
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

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours =
        duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours$minutes:$seconds';
  }
}
