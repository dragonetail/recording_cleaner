import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recording_cleaner/domain/services/audio_player_service.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_event.dart';
import 'package:recording_cleaner/presentation/blocs/audio_player/audio_player_state.dart';

/// 音频播放BLoC
class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayerService _playerService;
  StreamSubscription<Duration>? _positionSubscription;
  String? _currentFilePath;

  AudioPlayerBloc({
    required AudioPlayerService playerService,
  })  : _playerService = playerService,
        super(AudioPlayerInitial()) {
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<ResumeAudio>(_onResumeAudio);
    on<StopAudio>(_onStopAudio);
    on<SeekAudio>(_onSeekAudio);

    _positionSubscription = _playerService.positionStream.listen((position) {
      if (state is AudioPlayerPlaying && _currentFilePath != null) {
        emit(AudioPlayerPlaying(
          filePath: _currentFilePath!,
          position: position,
          duration: _playerService.duration ?? Duration.zero,
        ));
      }
    });
  }

  Future<void> _onPlayAudio(
    PlayAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      emit(AudioPlayerLoading(event.filePath));
      await _playerService.play(event.filePath);
      _currentFilePath = event.filePath;
      emit(AudioPlayerPlaying(
        filePath: event.filePath,
        position: Duration.zero,
        duration: _playerService.duration ?? Duration.zero,
      ));
    } catch (e) {
      emit(AudioPlayerError(e.toString()));
    }
  }

  Future<void> _onPauseAudio(
    PauseAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerPlaying && _currentFilePath != null) {
      try {
        await _playerService.pause();
        emit(AudioPlayerPaused(
          filePath: _currentFilePath!,
          position: (state as AudioPlayerPlaying).position,
          duration: (state as AudioPlayerPlaying).duration,
        ));
      } catch (e) {
        emit(AudioPlayerError(e.toString()));
      }
    }
  }

  Future<void> _onResumeAudio(
    ResumeAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerPaused && _currentFilePath != null) {
      try {
        await _playerService.play(_currentFilePath!);
        emit(AudioPlayerPlaying(
          filePath: _currentFilePath!,
          position: (state as AudioPlayerPaused).position,
          duration: (state as AudioPlayerPaused).duration,
        ));
      } catch (e) {
        emit(AudioPlayerError(e.toString()));
      }
    }
  }

  Future<void> _onStopAudio(
    StopAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      await _playerService.stop();
      _currentFilePath = null;
      emit(AudioPlayerStopped());
    } catch (e) {
      emit(AudioPlayerError(e.toString()));
    }
  }

  Future<void> _onSeekAudio(
    SeekAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if ((state is AudioPlayerPlaying || state is AudioPlayerPaused) &&
        _currentFilePath != null) {
      try {
        await _playerService.seek(event.position);
        if (state is AudioPlayerPlaying) {
          emit(AudioPlayerPlaying(
            filePath: _currentFilePath!,
            position: event.position,
            duration: (state as AudioPlayerPlaying).duration,
          ));
        } else {
          emit(AudioPlayerPaused(
            filePath: _currentFilePath!,
            position: event.position,
            duration: (state as AudioPlayerPaused).duration,
          ));
        }
      } catch (e) {
        emit(AudioPlayerError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _playerService.dispose();
    return super.close();
  }
}
