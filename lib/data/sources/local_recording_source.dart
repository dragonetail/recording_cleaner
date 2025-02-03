import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recording_cleaner/data/models/recording_model.dart';
import 'package:recording_cleaner/data/sources/recording_source.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';

class LocalRecordingSource implements RecordingSource {
  final AppLogger _logger;
  final AudioPlayer _audioPlayer;

  LocalRecordingSource({
    required AppLogger logger,
    required AudioPlayer audioPlayer,
  })  : _logger = logger,
        _audioPlayer = audioPlayer;

  Future<void> createTestData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final recordingsDir = Directory('${directory.path}/recordings');
      if (!await recordingsDir.exists()) {
        await recordingsDir.create(recursive: true);
      }

      // 创建测试文件
      final testFiles = [
        // 最近录音 (90天内)
        {
          'name': '今天的录音.m4a',
          'size': 1024 * 1024 * 2, // 2MB
          'duration': const Duration(minutes: 5),
          'createdAt': DateTime.now(),
        },
        {
          'name': '昨天的录音.m4a',
          'size': 1024 * 1024 * 5, // 5MB
          'duration': const Duration(minutes: 8),
          'createdAt': DateTime.now().subtract(const Duration(days: 1)),
        },
        {
          'name': '一周前的录音.m4a',
          'size': 1024 * 1024 * 8, // 8MB
          'duration': const Duration(minutes: 12),
          'createdAt': DateTime.now().subtract(const Duration(days: 7)),
        },
        {
          'name': '一个月前的录音.m4a',
          'size': 1024 * 1024 * 15, // 15MB
          'duration': const Duration(minutes: 25),
          'createdAt': DateTime.now().subtract(const Duration(days: 30)),
        },

        // 90天前的录音
        {
          'name': '三个月前的录音.m4a',
          'size': 1024 * 1024 * 20, // 20MB
          'duration': const Duration(minutes: 45),
          'createdAt': DateTime.now().subtract(const Duration(days: 91)),
        },
        {
          'name': '四个月前的录音.m4a',
          'size': 1024 * 1024 * 25, // 25MB
          'duration': const Duration(hours: 1, minutes: 15),
          'createdAt': DateTime.now().subtract(const Duration(days: 120)),
        },
        {
          'name': '半年前的录音.m4a',
          'size': 1024 * 1024 * 35, // 35MB
          'duration': const Duration(hours: 1, minutes: 45),
          'createdAt': DateTime.now().subtract(const Duration(days: 180)),
        },

        // 一年前的录音
        {
          'name': '去年的录音1.m4a',
          'size': 1024 * 1024 * 50, // 50MB
          'duration': const Duration(hours: 2, minutes: 15),
          'createdAt': DateTime.now().subtract(const Duration(days: 366)),
        },
        {
          'name': '去年的录音2.m4a',
          'size': 1024 * 1024 * 65, // 65MB
          'duration': const Duration(hours: 2, minutes: 45),
          'createdAt': DateTime.now().subtract(const Duration(days: 400)),
        },
        {
          'name': '去年的录音3.m4a',
          'size': 1024 * 1024 * 80, // 80MB
          'duration': const Duration(hours: 3, minutes: 30),
          'createdAt': DateTime.now().subtract(const Duration(days: 450)),
        },

        // 按时长分类的测试数据
        {
          'name': '短录音1.m4a',
          'size': 1024 * 1024 * 1, // 1MB
          'duration': const Duration(minutes: 3),
          'createdAt': DateTime.now().subtract(const Duration(days: 5)),
        },
        {
          'name': '短录音2.m4a',
          'size': 1024 * 1024 * 2, // 2MB
          'duration': const Duration(minutes: 7),
          'createdAt': DateTime.now().subtract(const Duration(days: 15)),
        },
        {
          'name': '中等录音1.m4a',
          'size': 1024 * 1024 * 12, // 12MB
          'duration': const Duration(minutes: 25),
          'createdAt': DateTime.now().subtract(const Duration(days: 45)),
        },
        {
          'name': '中等录音2.m4a',
          'size': 1024 * 1024 * 28, // 28MB
          'duration': const Duration(minutes: 55),
          'createdAt': DateTime.now().subtract(const Duration(days: 75)),
        },
        {
          'name': '长录音1.m4a',
          'size': 1024 * 1024 * 45, // 45MB
          'duration': const Duration(hours: 2, minutes: 15),
          'createdAt': DateTime.now().subtract(const Duration(days: 150)),
        },
        {
          'name': '长录音2.m4a',
          'size': 1024 * 1024 * 75, // 75MB
          'duration': const Duration(hours: 3, minutes: 45),
          'createdAt': DateTime.now().subtract(const Duration(days: 250)),
        },
      ];

      for (final testFile in testFiles) {
        testFile['path'] = '${recordingsDir.path}/none-${testFile['name']}';
        // _logger.i('文件不存在，跳过创建: ${testFile['name']}');
      }

      _logger.i('测试数据创建完成');
    } catch (e, stackTrace) {
      _logger.e(
        '创建测试数据失败',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<List<RecordingModel>> getRecordings() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final recordingsDir = Directory('${directory.path}/recordings');
      if (!await recordingsDir.exists()) {
        await recordingsDir.create(recursive: true);
      }

      final files = await recordingsDir
          .list()
          .where((entity) => entity is File && entity.path.endsWith('.m4a'))
          .cast<File>()
          .toList();

      final recordings = <RecordingModel>[];
      for (final file in files) {
        try {
          final stats = await file.stat();
          final duration = await getAudioDuration(file.path);
          final size = await getFileSize(file.path);

          recordings.add(RecordingModel(
            id: file.path,
            name: file.path.split('/').last,
            path: file.path,
            size: size,
            duration: duration,
            createdAt: stats.changed,
            updatedAt: stats.modified,
          ));
        } catch (e, stackTrace) {
          _logger.e(
            '获取录音文件信息失败: ${file.path}',
            error: e,
            stackTrace: stackTrace,
          );
        }
      }

      return recordings;
    } catch (e, stackTrace) {
      _logger.e(
        '获取录音文件列表失败',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> deleteRecordings(List<String> ids) async {
    try {
      for (final id in ids) {
        final file = File(id);
        if (await file.exists()) {
          await file.delete();
        }
      }
      return true;
    } catch (e, stackTrace) {
      _logger.e(
        '删除录音文件失败',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<RecordingModel?> getRecording(String id) async {
    try {
      final file = File(id);
      if (!await file.exists()) {
        return null;
      }

      final stats = await file.stat();
      final duration = await getAudioDuration(file.path);
      final size = await getFileSize(file.path);

      return RecordingModel(
        id: file.path,
        name: file.path.split('/').last,
        path: file.path,
        size: size,
        duration: duration,
        createdAt: stats.changed,
        updatedAt: stats.modified,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '获取录音文件失败: $id',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<bool> updateRecording(RecordingModel recording) async {
    try {
      final file = File(recording.path);
      if (!await file.exists()) {
        return false;
      }

      final newFile = File('${file.parent.path}/${recording.name}');
      await file.rename(newFile.path);
      return true;
    } catch (e, stackTrace) {
      _logger.e(
        '更新录音文件失败: ${recording.id}',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<Duration> getAudioDuration(String path) async {
    try {
      if (true) {
        // if (true || path.contains('/none-')) {
        // _logger.i('跳过音频处理: $path');
        return Duration(milliseconds: 200000);
      }
      await _audioPlayer.setFilePath(path);
      return _audioPlayer.duration ?? Duration.zero;
    } catch (e, stackTrace) {
      _logger.e(
        '获取音频时长失败: $path',
        error: e,
        stackTrace: stackTrace,
      );
      return Duration.zero;
    }
  }

  @override
  Future<int> getFileSize(String path) async {
    try {
      final file = File(path);
      return await file.length();
    } catch (e, stackTrace) {
      _logger.e(
        '获取文件大小失败: $path',
        error: e,
        stackTrace: stackTrace,
      );
      return 0;
    }
  }
}
