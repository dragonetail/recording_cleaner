import 'package:equatable/equatable.dart';

/// 音频播放事件基类
abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object?> get props => [];
}

/// 播放音频事件
class PlayAudio extends AudioPlayerEvent {
  final String filePath;

  const PlayAudio(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

/// 暂停音频事件
class PauseAudio extends AudioPlayerEvent {
  const PauseAudio();
}

/// 恢复播放事件
class ResumeAudio extends AudioPlayerEvent {
  const ResumeAudio();
}

/// 停止播放事件
class StopAudio extends AudioPlayerEvent {
  const StopAudio();
}

/// 音频定位事件
class SeekAudio extends AudioPlayerEvent {
  final Duration position;

  const SeekAudio(this.position);

  @override
  List<Object?> get props => [position];
}
