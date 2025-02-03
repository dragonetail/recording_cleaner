import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_bloc.dart';
import 'package:recording_cleaner/presentation/widgets/recording_actions_menu.dart';
import 'package:recording_cleaner/presentation/widgets/recording_info_dialog.dart';
import 'package:recording_cleaner/presentation/widgets/recording_rename_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class RecordingListItem extends StatelessWidget {
  final RecordingEntity recording;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onSelectionChanged;
  final ValueChanged<String>? onRename;
  final ValueChanged<String>? onDelete;

  const RecordingListItem({
    Key? key,
    required this.recording,
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

  Widget _buildPlayButton(BuildContext context, AudioPlayerState state) {
    if (state is AudioPlayerLoading &&
        (state is AudioPlayerPlaying || state is AudioPlayerPaused) &&
        (state as dynamic).filePath == recording.path) {
      return SizedBox(
        width: 24.w,
        height: 24.w,
        child: CircularProgressIndicator(
          strokeWidth: 2.w,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    final bool isPlaying =
        state is AudioPlayerPlaying && state.filePath == recording.path;

    return IconButton(
      icon: Icon(
        isPlaying ? Icons.pause_circle : Icons.play_circle,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        if (isPlaying) {
          context.read<AudioPlayerBloc>().add(PauseAudio());
        } else {
          context.read<AudioPlayerBloc>().add(PlayAudio(recording.path));
        }
      },
    );
  }

  Widget _buildProgressBar(BuildContext context, AudioPlayerState state) {
    if (!(state is AudioPlayerPlaying || state is AudioPlayerPaused) ||
        (state as dynamic).filePath != recording.path) {
      return const SizedBox.shrink();
    }

    final Duration position = (state is AudioPlayerPlaying)
        ? (state as AudioPlayerPlaying).position
        : (state as AudioPlayerPaused).position;

    final Duration? duration = (state is AudioPlayerPlaying)
        ? (state as AudioPlayerPlaying).duration
        : (state as AudioPlayerPaused).duration;

    return Column(
      children: [
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              _formatDuration(position),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Expanded(
              child: Slider(
                value: position.inMilliseconds.toDouble(),
                min: 0,
                max: duration?.inMilliseconds.toDouble() ??
                    recording.duration.inMilliseconds.toDouble(),
                onChanged: (value) {
                  context.read<AudioPlayerBloc>().add(
                        SeekAudio(Duration(milliseconds: value.toInt())),
                      );
                },
              ),
            ),
            Text(
              _formatDuration(duration ?? recording.duration),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        return GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isSelectionMode)
                      Checkbox(
                        value: isSelected,
                        onChanged: (value) =>
                            onSelectionChanged?.call(value ?? false),
                      )
                    else
                      _buildPlayButton(context, state),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recording.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(recording.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatFileSize(recording.size),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _formatDuration(recording.duration),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    if (!isSelectionMode) ...[
                      SizedBox(width: 8.w),
                      RecordingActionsMenu(
                        recording: recording,
                        onRename: onRename != null
                            ? () => _showRenameDialog(context)
                            : null,
                        onShare: () => _shareRecording(),
                        onInfo: () => _showInfoDialog(context),
                        onDelete: onDelete != null
                            ? () => _showDeleteConfirmation(context)
                            : null,
                      ),
                    ],
                  ],
                ),
                _buildProgressBar(context, state),
              ],
            ),
          ),
        );
      },
    );
  }
}
