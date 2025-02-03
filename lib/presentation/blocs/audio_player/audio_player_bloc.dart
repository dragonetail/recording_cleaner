import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_event.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_state.dart';

/// 音频播放器 BLoC
class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  /// 创建[AudioPlayerBloc]实例
  AudioPlayerBloc({
    required AppLogger logger,
  })  : _logger = logger,
        _player = AudioPlayer(),
        super(AudioPlayerState.initial()) {
    on<LoadAudioFile>(_onLoadAudioFile);
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<SeekAudio>(_onSeekAudio);
    on<UpdatePosition>(_onUpdatePosition);
    on<UpdateDuration>(_onUpdateDuration);
    on<UpdatePlayingState>(_onUpdatePlayingState);
    on<AudioCompleted>(_onAudioCompleted);
    on<AudioError>(_onAudioError);

    _player.positionStream.listen((position) {
      add(UpdatePosition(position));
    });

    _player.durationStream.listen((duration) {
      if (duration != null) {
        add(UpdateDuration(duration));
      }
    });

    _player.playingStream.listen((isPlaying) {
      add(UpdatePlayingState(isPlaying));
    });

    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        add(const AudioCompleted());
      }
    });
  }

  final AppLogger _logger;
  final AudioPlayer _player;

  @override
  Future<void> close() async {
    await _player.dispose();
    return super.close();
  }

  Future<void> _onLoadAudioFile(
    LoadAudioFile event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      final file = File(event.filePath);
      if (!await file.exists()) {
        throw '文件不存在';
      }

      await _player.setFilePath(event.filePath);

      emit(state.copyWith(
        fileName: path.basename(event.filePath),
        isLoading: false,
      ));
    } catch (e, s) {
      _logger.e('加载音频文件失败', error: e, stackTrace: s);
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onPlayAudio(
    PlayAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      await _player.play();
    } catch (e, s) {
      _logger.e('播放音频失败', error: e, stackTrace: s);
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPauseAudio(
    PauseAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      await _player.pause();
    } catch (e, s) {
      _logger.e('暂停音频失败', error: e, stackTrace: s);
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onSeekAudio(
    SeekAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      await _player.seek(event.position);
    } catch (e, s) {
      _logger.e('音频定位失败', error: e, stackTrace: s);
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onUpdatePosition(
    UpdatePosition event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(position: event.position));
  }

  void _onUpdateDuration(
    UpdateDuration event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onUpdatePlayingState(
    UpdatePlayingState event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(isPlaying: event.isPlaying));
  }

  void _onAudioCompleted(
    AudioCompleted event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(
      position: state.duration,
      isPlaying: false,
    ));
  }

  void _onAudioError(
    AudioError event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(
      error: event.error,
      isPlaying: false,
    ));
  }
}
