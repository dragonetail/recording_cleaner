import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/domain/services/audio_player_service.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_state.dart';
import 'package:recording_cleaner/presentation/widgets/recording_list_item.dart';
import 'package:recording_cleaner/presentation/widgets/recording_filter_dialog.dart';
import 'package:recording_cleaner/data/models/recording_model.dart';

class RecordingsPage extends StatefulWidget {
  const RecordingsPage({Key? key}) : super(key: key);

  @override
  State<RecordingsPage> createState() => _RecordingsPageState();
}

class _RecordingsPageState extends State<RecordingsPage> {
  late final AudioPlayer _audioPlayer;
  late final Logger _logger;
  late final AudioPlayerService _audioPlayerService;
  late final AudioPlayerBloc _audioPlayerBloc;
  String? _currentTimeFilter;
  String? _currentDurationFilter;
  String? _currentSortBy;
  bool? _currentAscending;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _logger = Logger();
    _audioPlayerService = AudioPlayerService(
      player: _audioPlayer,
      logger: _logger,
    );
    _audioPlayerBloc = AudioPlayerBloc(playerService: _audioPlayerService);

    // 初始加载录音列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecordingsBloc>().add(const LoadRecordings());
    });
  }

  @override
  void dispose() {
    _audioPlayerBloc.close();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _showFilterDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) => RecordingFilterDialog(
        timeFilter: _currentTimeFilter,
        durationFilter: _currentDurationFilter,
        sortBy: _currentSortBy,
        ascending: _currentAscending,
        onApply: (timeFilter, durationFilter, sortBy, ascending) {
          setState(() {
            _currentTimeFilter = timeFilter;
            _currentDurationFilter = durationFilter;
            _currentSortBy = sortBy;
            _currentAscending = ascending;
          });

          context.read<RecordingsBloc>().add(
                LoadRecordings(
                  timeFilter: timeFilter,
                  durationFilter: durationFilter,
                  sortBy: sortBy,
                  ascending: ascending,
                ),
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _audioPlayerBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AudioPlayerBloc, AudioPlayerState>(
            listener: (context, state) {
              if (state is AudioPlayerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('播放错误: ${state.message}'),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<RecordingsBloc, RecordingsState>(
              builder: (context, state) {
                if (state is RecordingsLoaded && state.isSelectionMode) {
                  return Text('已选择 ${state.selectedIds.length} 项');
                }
                return const Text('录音列表');
              },
            ),
            actions: [
              BlocBuilder<RecordingsBloc, RecordingsState>(
                builder: (context, state) {
                  if (state is RecordingsLoaded) {
                    if (state.isSelectionMode) {
                      return Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.select_all),
                            onPressed: () {
                              context.read<RecordingsBloc>().add(
                                    SelectAllRecordings(
                                      state.selectedIds.length !=
                                          state.recordings.length,
                                    ),
                                  );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: state.selectedIds.isEmpty
                                ? null
                                : () {
                                    context.read<RecordingsBloc>().add(
                                          DeleteRecordings(
                                            state.selectedIds.toList(),
                                          ),
                                        );
                                    context.read<RecordingsBloc>().add(
                                          ToggleSelectionMode(false),
                                        );
                                  },
                          ),
                        ],
                      );
                    }
                    return IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: _showFilterDialog,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          body: BlocBuilder<RecordingsBloc, RecordingsState>(
            builder: (context, state) {
              if (state is RecordingsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is RecordingsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        '加载失败: ${state.message}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<RecordingsBloc>().add(
                                const LoadRecordings(),
                              );
                        },
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                );
              }

              if (state is RecordingsLoaded) {
                if (state.recordings.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mic_none,
                          size: 48.w,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          '暂无录音',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<RecordingsBloc>().add(const LoadRecordings());
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.recordings.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final recording = state.recordings[index];
                      return RecordingListItem(
                        recording: recording,
                        isSelectionMode: state.isSelectionMode,
                        isSelected: state.selectedIds.contains(recording.id),
                        onLongPress: () {
                          if (!state.isSelectionMode) {
                            context.read<RecordingsBloc>().add(
                                  ToggleSelectionMode(true),
                                );
                            context.read<RecordingsBloc>().add(
                                  ToggleRecordingSelection(
                                    recording.id,
                                    true,
                                  ),
                                );
                          }
                        },
                        onSelectionChanged: (selected) {
                          context.read<RecordingsBloc>().add(
                                ToggleRecordingSelection(
                                  recording.id,
                                  selected,
                                ),
                              );
                        },
                        onRename: (newName) {
                          final newRecording =
                              RecordingModel.fromEntity(recording).copyWith(
                            name: newName,
                            updatedAt: DateTime.now(),
                          );
                          context.read<RecordingsBloc>().add(
                                UpdateRecording(newRecording),
                              );
                        },
                        onDelete: (id) {
                          context.read<RecordingsBloc>().add(
                                DeleteRecordings([id]),
                              );
                        },
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
