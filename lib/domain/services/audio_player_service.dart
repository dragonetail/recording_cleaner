import 'package:just_audio/just_audio.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';

class AudioPlayerService {
  final AudioPlayer _player;
  final AppLogger _logger;

  AudioPlayerService({
    required AudioPlayer player,
    required AppLogger logger,
  })  : _player = player,
        _logger = logger;

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Duration? get duration => _player.duration;
  bool get isPlaying => _player.playing;

  Future<void> play(String filePath) async {
    try {
      await _player.setFilePath(filePath);
      await _player.play();
    } catch (e, stackTrace) {
      _logger.e('播放音频失败: $filePath', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e, stackTrace) {
      _logger.e('暂停音频失败', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e, stackTrace) {
      _logger.e('停止音频失败', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e, stackTrace) {
      _logger.e('音频定位失败: $position', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> dispose() async {
    try {
      await _player.dispose();
    } catch (e, stackTrace) {
      _logger.e('释放音频播放器失败', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
