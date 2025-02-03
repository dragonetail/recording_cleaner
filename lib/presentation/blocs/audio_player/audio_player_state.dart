import 'package:equatable/equatable.dart';

/// 音频播放状态基类
abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object?> get props => [];
}

/// 初始状态
class AudioPlayerInitial extends AudioPlayerState {
  const AudioPlayerInitial();
}

/// 加载中状态
class AudioPlayerLoading extends AudioPlayerState {
  final String filePath;

  const AudioPlayerLoading(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

/// 播放中状态
class AudioPlayerPlaying extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration duration;

  const AudioPlayerPlaying({
    required this.filePath,
    required this.position,
    required this.duration,
  });

  @override
  List<Object?> get props => [filePath, position, duration];
}

/// 暂停状态
class AudioPlayerPaused extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration duration;

  const AudioPlayerPaused({
    required this.filePath,
    required this.position,
    required this.duration,
  });

  @override
  List<Object?> get props => [filePath, position, duration];
}

/// 停止状态
class AudioPlayerStopped extends AudioPlayerState {
  const AudioPlayerStopped();
}

/// 错误状态
class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
