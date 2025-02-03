import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/services/audio_player_service.dart';
import 'package:just_audio/just_audio.dart';

// Events
abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayAudio extends AudioPlayerEvent {
  final String filePath;

  const PlayAudio(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class PauseAudio extends AudioPlayerEvent {}

class StopAudio extends AudioPlayerEvent {}

class SeekAudio extends AudioPlayerEvent {
  final Duration position;

  const SeekAudio(this.position);

  @override
  List<Object?> get props => [position];
}

// States
abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object?> get props => [];
}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerPlaying extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration? duration;

  const AudioPlayerPlaying({
    required this.filePath,
    required this.position,
    this.duration,
  });

  @override
  List<Object?> get props => [filePath, position, duration];

  AudioPlayerPlaying copyWith({
    String? filePath,
    Duration? position,
    Duration? duration,
  }) {
    return AudioPlayerPlaying(
      filePath: filePath ?? this.filePath,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}

class AudioPlayerPaused extends AudioPlayerState {
  final String filePath;
  final Duration position;
  final Duration? duration;

  const AudioPlayerPaused({
    required this.filePath,
    required this.position,
    this.duration,
  });

  @override
  List<Object?> get props => [filePath, position, duration];
}

class AudioPlayerStopped extends AudioPlayerState {}

class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayerService _playerService;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  AudioPlayerBloc({required AudioPlayerService playerService})
      : _playerService = playerService,
        super(AudioPlayerInitial()) {
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<StopAudio>(_onStopAudio);
    on<SeekAudio>(_onSeekAudio);

    _playerStateSubscription = _playerService.playerStateStream.listen(
      (playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          add(StopAudio());
        }
      },
    );
  }

  Future<void> _onPlayAudio(
    PlayAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      emit(AudioPlayerLoading());
      await _playerService.play(event.filePath);

      _positionSubscription?.cancel();
      _positionSubscription = _playerService.positionStream.listen(
        (position) {
          if (state is AudioPlayerPlaying) {
            emit((state as AudioPlayerPlaying).copyWith(position: position));
          }
        },
      );

      emit(AudioPlayerPlaying(
        filePath: event.filePath,
        position: Duration.zero,
        duration: _playerService.duration,
      ));
    } catch (e) {
      emit(AudioPlayerError(e.toString()));
    }
  }

  Future<void> _onPauseAudio(
    PauseAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerPlaying) {
      try {
        final currentState = state as AudioPlayerPlaying;
        await _playerService.pause();
        emit(AudioPlayerPaused(
          filePath: currentState.filePath,
          position: currentState.position,
          duration: currentState.duration,
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
      _positionSubscription?.cancel();
      _positionSubscription = null;
      emit(AudioPlayerStopped());
    } catch (e) {
      emit(AudioPlayerError(e.toString()));
    }
  }

  Future<void> _onSeekAudio(
    SeekAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerPlaying || state is AudioPlayerPaused) {
      try {
        await _playerService.seek(event.position);
        if (state is AudioPlayerPlaying) {
          emit(
              (state as AudioPlayerPlaying).copyWith(position: event.position));
        } else if (state is AudioPlayerPaused) {
          final currentState = state as AudioPlayerPaused;
          emit(AudioPlayerPaused(
            filePath: currentState.filePath,
            position: event.position,
            duration: currentState.duration,
          ));
        }
      } catch (e) {
        emit(AudioPlayerError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await _playerService.dispose();
    return super.close();
  }
}
