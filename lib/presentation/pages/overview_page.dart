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
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_event.dart';
import 'package:recording_cleaner/presentation/blocs/overview/overview_state.dart';
import 'package:recording_cleaner/presentation/widgets/empty_state.dart';
import 'package:recording_cleaner/presentation/widgets/file_stats_card.dart';
import 'package:recording_cleaner/presentation/widgets/loading_state.dart';
import 'package:recording_cleaner/presentation/widgets/storage_card.dart';

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
      child: const _OverviewContent(),
    );
  }
}

class _OverviewContent extends StatelessWidget {
  const _OverviewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('录音空间清理'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<OverviewBloc>().add(const RefreshOverviewData());
            },
          ),
        ],
      ),
      body: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingState();
          }

          if (state.error != null) {
            return ErrorState(
              message: state.error!,
              onRetry: () {
                context.read<OverviewBloc>().add(const LoadOverviewData());
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<OverviewBloc>().add(const RefreshOverviewData());
            },
            child: AnimationLimiter(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                children: AnimationConfiguration.toStaggeredList(
                  duration: AppConstants.listItemAnimationDuration,
                  delay: AppConstants.listAnimationDelay,
                  childAnimationBuilder: (child) => SlideAnimation(
                    verticalOffset: 50.h,
                    child: FadeInAnimation(
                      child: child,
                    ),
                  ),
                  children: [
                    StorageCard(
                      usedStorage: state.usedStorage,
                      totalStorage: state.totalStorage,
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: FileStatsCard(
                              icon: Icons.mic_rounded,
                              title: '录音文件',
                              count: state.recordingsCount,
                              duration: state.recordingsDuration,
                              size: state.recordingsSize,
                              totalSize: state.usedStorage,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: FileStatsCard(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
