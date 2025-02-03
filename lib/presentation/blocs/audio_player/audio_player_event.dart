import 'package:equatable/equatable.dart';

/// 音频播放器事件
abstract class AudioPlayerEvent extends Equatable {
  /// 创建[AudioPlayerEvent]实例
  const AudioPlayerEvent();

  @override
  List<Object?> get props => [];
}

/// 加载音频文件事件
class LoadAudioFile extends AudioPlayerEvent {
  /// 创建[LoadAudioFile]实例
  const LoadAudioFile(this.filePath);

  /// 文件路径
  final String filePath;

  @override
  List<Object?> get props => [filePath];
}

/// 播放音频事件
class PlayAudio extends AudioPlayerEvent {
  /// 创建[PlayAudio]实例
  const PlayAudio();
}

/// 暂停音频事件
class PauseAudio extends AudioPlayerEvent {
  /// 创建[PauseAudio]实例
  const PauseAudio();
}

/// 跳转音频事件
class SeekAudio extends AudioPlayerEvent {
  /// 创建[SeekAudio]实例
  const SeekAudio(this.position);

  /// 目标位置
  final Duration position;

  @override
  List<Object?> get props => [position];
}

/// 更新音频位置事件
class UpdatePosition extends AudioPlayerEvent {
  /// 创建[UpdatePosition]实例
  const UpdatePosition(this.position);

  /// 当前位置
  final Duration position;

  @override
  List<Object?> get props => [position];
}

/// 更新音频时长事件
class UpdateDuration extends AudioPlayerEvent {
  /// 创建[UpdateDuration]实例
  const UpdateDuration(this.duration);

  /// 总时长
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

/// 更新播放状态事件
class UpdatePlayingState extends AudioPlayerEvent {
  /// 创建[UpdatePlayingState]实例
  const UpdatePlayingState(this.isPlaying);

  /// 是否正在播放
  final bool isPlaying;

  @override
  List<Object?> get props => [isPlaying];
}

/// 音频播放完成事件
class AudioCompleted extends AudioPlayerEvent {
  /// 创建[AudioCompleted]实例
  const AudioCompleted();
}

/// 音频播放错误事件
class AudioError extends AudioPlayerEvent {
  /// 创建[AudioError]实例
  const AudioError(this.error);

  /// 错误信息
  final String error;

  @override
  List<Object?> get props => [error];
}
