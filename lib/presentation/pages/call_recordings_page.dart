import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/blocs/call_recordings/call_recordings_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/call_recordings/call_recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/call_recordings/call_recordings_state.dart';
import 'package:recording_cleaner/presentation/widgets/call_recording_list_item.dart';
import 'package:recording_cleaner/presentation/widgets/empty_state.dart';
import 'package:recording_cleaner/presentation/widgets/loading_state.dart';
import 'package:recording_cleaner/presentation/widgets/selection_mode.dart';

/// 通话录音列表页面
class CallRecordingsPage extends StatelessWidget {
  /// 创建[CallRecordingsPage]实例
  const CallRecordingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallRecordingsBloc(
        logger: appLogger,
        callRecordingRepository: context.read(),
      )..add(const LoadCallRecordings()),
      child: const _CallRecordingsContent(),
    );
  }
}

class _CallRecordingsContent extends StatelessWidget {
  const _CallRecordingsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallRecordingsBloc, CallRecordingsState>(
      builder: (context, state) {
        final appBar = state.isSelectionMode
            ? SelectionModeAppBar(
                selectedCount: state.selectedRecordings.length,
                totalCount: state.recordings.length,
                onSelectAll: () {
                  context
                      .read<CallRecordingsBloc>()
                      .add(const ToggleSelectAll());
                },
                onDelete: () async {
                  context
                      .read<CallRecordingsBloc>()
                      .add(DeleteSelectedCallRecordings());
                  return true;
                },
                onShare: () {
                  // TODO: 实现分享功能
                },
                onCancel: () {
                  context
                      .read<CallRecordingsBloc>()
                      .add(const ExitSelectionMode());
                },
              )
            : AppBar(
                title: const Text('通话录音'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.checklist_rounded),
                    onPressed: () {
                      context
                          .read<CallRecordingsBloc>()
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
                          .read<CallRecordingsBloc>()
                          .add(const LoadCallRecordings());
                    },
                  )
                : state.recordings.isEmpty
                    ? const EmptyState(
                        message: '暂无通话录音',
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<CallRecordingsBloc>()
                              .add(const LoadCallRecordings());
                        },
                        child: AnimationLimiter(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            itemCount: state.recordings.length,
                            itemBuilder: (context, index) {
                              final recording = state.recordings[index];
                              return CallRecordingListItem(
                                index: index,
                                name: recording.contact.name,
                                phoneNumber: recording.contact.phoneNumber,
                                duration: recording.duration,
                                size: recording.size,
                                samples: recording.samples,
                                dateTime: recording.dateTime,
                                onTap: () {
                                  // TODO: 实现播放功能
                                },
                                onDelete: () async {
                                  context.read<CallRecordingsBloc>().add(
                                        DeleteCallRecordings([recording.id]),
                                      );
                                  return true;
                                },
                                onToggleImportant: () {
                                  context.read<CallRecordingsBloc>().add(
                                        ToggleCallRecordingImportance(
                                          recording.id,
                                        ),
                                      );
                                },
                                isImportant: recording.isImportant,
                                isSelected: state.selectedRecordings
                                    .contains(recording.id),
                                onSelectedChanged: state.isSelectionMode
                                    ? (selected) {
                                        context.read<CallRecordingsBloc>().add(
                                              ToggleCallRecordingSelection(
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
                    context
                        .read<CallRecordingsBloc>()
                        .add(const ToggleSelectAll());
                  },
                  onDelete: () async {
                    context
                        .read<CallRecordingsBloc>()
                        .add(DeleteSelectedCallRecordings());
                    return true;
                  },
                  onShare: () {
                    // TODO: 实现分享功能
                  },
                  onCancel: () {
                    context
                        .read<CallRecordingsBloc>()
                        .add(const ExitSelectionMode());
                  },
                )
              : null,
        );
      },
    );
  }
}
