import 'package:recording_cleaner/data/models/recording_model.dart';
import 'package:recording_cleaner/data/sources/recording_source.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';

class RecordingRepositoryImpl implements RecordingRepository {
  final RecordingSource _source;

  RecordingRepositoryImpl(this._source);

  @override
  Future<List<RecordingEntity>> getRecordings({
    String? timeFilter,
    String? durationFilter,
    String? sortBy,
    bool? ascending,
  }) async {
    final recordings = await _source.getRecordings();
    var filteredRecordings = recordings.where((r) => !r.isDeleted).toList();

    // 应用时间过滤
    if (timeFilter != null) {
      final now = DateTime.now();
      filteredRecordings = filteredRecordings.where((r) {
        final age = now.difference(r.createdAt);
        switch (timeFilter) {
          case 'time_year':
            return age > const Duration(days: 365);
          case 'time_90days':
            return age > const Duration(days: 90);
          case 'time_recent':
            return age <= const Duration(days: 90);
          default:
            return true;
        }
      }).toList();
    }

    // 应用时长过滤
    if (durationFilter != null) {
      filteredRecordings = filteredRecordings.where((r) {
        switch (durationFilter) {
          case 'duration_2h':
            return r.duration.inHours >= 2;
          case 'duration_10m':
            return r.duration.inMinutes >= 10 && r.duration.inHours < 2;
          case 'duration_under10m':
            return r.duration.inMinutes < 10;
          default:
            return true;
        }
      }).toList();
    }

    // 应用排序
    if (sortBy != null) {
      filteredRecordings.sort((a, b) {
        int comparison;
        switch (sortBy) {
          case 'time':
            comparison = a.createdAt.compareTo(b.createdAt);
            break;
          case 'size':
            comparison = a.size.compareTo(b.size);
            break;
          default:
            comparison = 0;
        }
        return ascending == true ? comparison : -comparison;
      });
    }

    return filteredRecordings;
  }

  @override
  Future<bool> deleteRecordings(List<String> ids) {
    return _source.deleteRecordings(ids);
  }

  @override
  Future<RecordingEntity?> getRecording(String id) {
    return _source.getRecording(id);
  }

  @override
  Future<bool> updateRecording(RecordingEntity recording) {
    return _source.updateRecording(RecordingModel.fromEntity(recording));
  }
}
