import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
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
    _audioPlayerService = AudioPlayerService(
      player: _audioPlayer,
      logger: appLogger,
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('录音文件'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
          ],
        ),
        body: BlocBuilder<RecordingsBloc, RecordingsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('加载失败：${state.error}'));
            }

            if (state.recordings.isEmpty) {
              return const Center(child: Text('暂无录音文件'));
            }

            return ListView.builder(
              itemCount: state.recordings.length,
              itemBuilder: (context, index) {
                final recording = state.recordings[index];
                return RecordingListItem(
                  recording: recording,
                  audioPlayerBloc: context.read<AudioPlayerBloc>(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
