import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_event.dart'
    as events;
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_state.dart'
    as states;
import 'package:recording_cleaner/presentation/widgets/recording_actions_menu.dart';
import 'package:recording_cleaner/presentation/widgets/recording_info_dialog.dart';
import 'package:recording_cleaner/presentation/widgets/recording_rename_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class RecordingListItem extends StatelessWidget {
  final RecordingEntity recording;
  final AudioPlayerBloc audioPlayerBloc;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onSelectionChanged;
  final ValueChanged<String>? onRename;
  final ValueChanged<String>? onDelete;

  const RecordingListItem({
    Key? key,
    required this.recording,
    required this.audioPlayerBloc,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onLongPress,
    this.onSelectionChanged,
    this.onRename,
    this.onDelete,
  }) : super(key: key);

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

  Future<void> _showRenameDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => RecordingRenameDialog(
        currentName: recording.name,
        onRename: (newName) {
          onRename?.call(newName);
        },
      ),
    );
  }

  Future<void> _showInfoDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => RecordingInfoDialog(recording: recording),
    );
  }

  Future<void> _shareRecording() async {
    await Share.shareXFiles(
      [XFile(recording.path)],
      text: recording.name,
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除"${recording.name}"吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      onDelete?.call(recording.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ListTile(
        title: Text(recording.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '创建时间：${recording.createdAt.toString().substring(0, 19)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '大小：${(recording.size / 1024 / 1024).toStringAsFixed(2)}MB',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '时长：${recording.duration.toString().split('.').first}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: StreamBuilder<states.AudioPlayerState>(
          stream: audioPlayerBloc.stream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            final isPlaying = state is states.AudioPlayerPlaying &&
                state.filePath == recording.path;
            final isPaused = state is states.AudioPlayerPaused &&
                state.filePath == recording.path;

            return IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: isPlaying || isPaused
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              onPressed: () {
                if (isPlaying) {
                  audioPlayerBloc.add(const events.PauseAudio());
                } else if (isPaused) {
                  audioPlayerBloc.add(const events.ResumeAudio());
                } else {
                  audioPlayerBloc.add(events.PlayAudio(recording.path));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
