import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/core/utils/app_utils.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_event.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_state.dart';

/// 音频播放器组件
class AudioPlayer extends StatelessWidget {
  /// 创建[AudioPlayer]实例
  const AudioPlayer({
    Key? key,
    required this.filePath,
    this.showTitle = true,
    this.title,
    this.subtitle,
    this.onTitleTap,
  }) : super(key: key);

  /// 文件路径
  final String filePath;

  /// 是否显示标题
  final bool showTitle;

  /// 标题
  final String? title;

  /// 副标题
  final String? subtitle;

  /// 标题点击回调
  final VoidCallback? onTitleTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioPlayerBloc(
        logger: context.read(),
      )..add(LoadAudioFile(filePath)),
      child: _AudioPlayerContent(
        showTitle: showTitle,
        title: title,
        subtitle: subtitle,
        onTitleTap: onTitleTap,
      ),
    );
  }
}

class _AudioPlayerContent extends StatelessWidget {
  const _AudioPlayerContent({
    Key? key,
    required this.showTitle,
    this.title,
    this.subtitle,
    this.onTitleTap,
  }) : super(key: key);

  final bool showTitle;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTitleTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showTitle) ...[
              ListTile(
                onTap: onTitleTap,
                title: Text(
                  title ?? state.fileName ?? '未知文件',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: subtitle != null
                    ? Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                trailing: state.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : state.error != null
                        ? Icon(
                            Icons.error_rounded,
                            color: colorScheme.error,
                          )
                        : null,
              ),
              const Divider(),
            ],
            if (state.error != null)
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  '加载失败：${state.error}',
                  style: TextStyle(
                    color: colorScheme.error,
                  ),
                ),
              )
            else
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Text(
                          AppUtils.formatDuration(state.position),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.position.inMilliseconds.toDouble(),
                            min: 0,
                            max: state.duration.inMilliseconds.toDouble(),
                            onChanged: state.isPlaying
                                ? (value) {
                                    context.read<AudioPlayerBloc>().add(
                                          SeekAudio(
                                            Duration(
                                              milliseconds: value.toInt(),
                                            ),
                                          ),
                                        );
                                  }
                                : null,
                          ),
                        ),
                        Text(
                          AppUtils.formatDuration(state.duration),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<AudioPlayerBloc>().add(
                                SeekAudio(
                                  state.position - const Duration(seconds: 10),
                                ),
                              );
                        },
                        icon: const Icon(Icons.replay_10_rounded),
                      ),
                      SizedBox(width: 16.w),
                      IconButton(
                        onPressed: () {
                          if (state.isPlaying) {
                            context
                                .read<AudioPlayerBloc>()
                                .add(const PauseAudio());
                          } else {
                            context
                                .read<AudioPlayerBloc>()
                                .add(const PlayAudio());
                          }
                        },
                        icon: Icon(
                          state.isPlaying
                              ? Icons.pause_circle_rounded
                              : Icons.play_circle_rounded,
                          size: 48.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      IconButton(
                        onPressed: () {
                          context.read<AudioPlayerBloc>().add(
                                SeekAudio(
                                  state.position + const Duration(seconds: 10),
                                ),
                              );
                        },
                        icon: const Icon(Icons.forward_10_rounded),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
