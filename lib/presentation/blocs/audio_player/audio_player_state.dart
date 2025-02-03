import 'package:equatable/equatable.dart';

/// 音频播放器状态
class AudioPlayerState extends Equatable {
  /// 创建[AudioPlayerState]实例
  const AudioPlayerState({
    this.fileName,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.isPlaying = false,
    this.isLoading = false,
    this.error,
  });

  /// 文件名
  final String? fileName;

  /// 总时长
  final Duration duration;

  /// 当前位置
  final Duration position;

  /// 是否正在播放
  final bool isPlaying;

  /// 是否正在加载
  final bool isLoading;

  /// 错误信息
  final String? error;

  /// 初始状态
  factory AudioPlayerState.initial() {
    return const AudioPlayerState();
  }

  /// 复制新实例
  AudioPlayerState copyWith({
    String? fileName,
    Duration? duration,
    Duration? position,
    bool? isPlaying,
    bool? isLoading,
    String? error,
  }) {
    return AudioPlayerState(
      fileName: fileName ?? this.fileName,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        fileName,
        duration,
        position,
        isPlaying,
        isLoading,
        error,
      ];
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
