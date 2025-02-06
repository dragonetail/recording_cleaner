import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_state.dart';
import 'package:recording_cleaner/presentation/widgets/empty_state.dart';
import 'package:recording_cleaner/presentation/widgets/loading_state.dart';
import 'package:recording_cleaner/presentation/widgets/recording_list_item.dart';
import 'package:recording_cleaner/presentation/widgets/selection_mode.dart';

/// 录音列表页面
class RecordingsPage extends StatelessWidget {
  /// 创建[RecordingsPage]实例
  const RecordingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecordingsBloc(
        logger: context.read<AppLogger>(),
        getRecordings: context.read(),
        deleteRecordings: context.read(),
        recordingRepository: context.read(),
      )..add(const LoadRecordings()),
      child: const _RecordingsContent(),
    );
  }
}

class _RecordingsContent extends StatelessWidget {
  const _RecordingsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingsBloc, RecordingsState>(
      builder: (context, state) {
        final appBar = state.isSelectionMode
            ? SelectionModeAppBar(
                selectedCount: state.selectedRecordings.length,
                totalCount: state.recordings.length,
                onSelectAll: () {
                  context.read<RecordingsBloc>().add(const ToggleSelectAll());
                },
                onDelete: () async {
                  context
                      .read<RecordingsBloc>()
                      .add(DeleteSelectedRecordings());
                  return true;
                },
                onShare: () {
                  // TODO: 实现分享功能
                },
                onCancel: () {
                  context.read<RecordingsBloc>().add(const ExitSelectionMode());
                },
              )
            : AppBar(
                title: const Text('录音文件'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.checklist_rounded),
                    onPressed: () {
                      context
                          .read<RecordingsBloc>()
                          .add(const EnterSelectionMode());
                    },
                  ),
                ],
              );

        final body = state.isLoading
            ? const LoadingState()
            : state.error != null
                ? ErrorState(
                    message: state.error!,
                    onRetry: () {
                      context
                          .read<RecordingsBloc>()
                          .add(const LoadRecordings());
                    },
                  )
                : state.recordings.isEmpty
                    ? const EmptyState(
                        message: '暂无录音文件',
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<RecordingsBloc>()
                              .add(const LoadRecordings());
                        },
                        child: AnimationLimiter(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            itemCount: state.recordings.length,
                            itemBuilder: (context, index) {
                              final recording = state.recordings[index];
                              return RecordingListItem(
                                index: index,
                                title: recording.name,
                                duration: recording.duration,
                                size: recording.size,
                                samples: recording.samples,
                                onTap: () {
                                  // TODO: 实现播放功能
                                },
                                onDelete: () async {
                                  context.read<RecordingsBloc>().add(
                                        DeleteRecordings([recording.id]),
                                      );
                                  return true;
                                },
                                onAction: () {
                                  // TODO: 实现收藏功能
                                },
                                actionLabel: '收藏',
                                isSelected: state.selectedRecordings
                                    .contains(recording.id),
                                onSelectedChanged: state.isSelectionMode
                                    ? (selected) {
                                        context.read<RecordingsBloc>().add(
                                              ToggleRecordingSelection(
                                                recording.id,
                                              ),
                                            );
                                      }
                                    : null,
                                showSlideAction: !state.isSelectionMode,
                              );
                            },
                          ),
                        ),
                      );

        return Scaffold(
          appBar: appBar,
          body: body,
          bottomNavigationBar: state.isSelectionMode
              ? SelectionMode(
                  selectedCount: state.selectedRecordings.length,
                  totalCount: state.recordings.length,
                  onSelectAll: () {
                    context.read<RecordingsBloc>().add(const ToggleSelectAll());
                  },
                  onDelete: () async {
                    context
                        .read<RecordingsBloc>()
                        .add(DeleteSelectedRecordings());
                    return true;
                  },
                  onShare: () {
                    // TODO: 实现分享功能
                  },
                  onCancel: () {
                    context
                        .read<RecordingsBloc>()
                        .add(const ExitSelectionMode());
                  },
                )
              : null,
        );
      },
    );
  }
}
