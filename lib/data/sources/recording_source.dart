import 'package:recording_cleaner/data/models/recording_model.dart';

abstract class RecordingSource {
  /// 获取所有录音文件
  Future<List<RecordingModel>> getRecordings();

  /// 删除录音文件
  Future<bool> deleteRecordings(List<String> ids);

  /// 获取单个录音文件
  Future<RecordingModel?> getRecording(String id);

  /// 更新录音文件
  Future<bool> updateRecording(RecordingModel recording);

  /// 获取文件时长
  Future<Duration> getAudioDuration(String path);

  /// 获取文件大小
  Future<int> getFileSize(String path);
}
