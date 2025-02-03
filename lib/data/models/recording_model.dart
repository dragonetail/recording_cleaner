import 'package:recording_cleaner/domain/entities/recording_entity.dart';

class RecordingModel extends RecordingEntity {
  const RecordingModel({
    required super.id,
    required super.name,
    required super.path,
    required super.size,
    required super.duration,
    required super.createdAt,
    required super.updatedAt,
    super.isDeleted,
  });

  factory RecordingModel.fromJson(Map<String, dynamic> json) {
    return RecordingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      size: json['size'] as int,
      duration: Duration(milliseconds: json['duration'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'size': size,
      'duration': duration.inMilliseconds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }

  factory RecordingModel.fromEntity(RecordingEntity entity) {
    return RecordingModel(
      id: entity.id,
      name: entity.name,
      path: entity.path,
      size: entity.size,
      duration: entity.duration,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDeleted: entity.isDeleted,
    );
  }

  RecordingModel copyWith({
    String? id,
    String? name,
    String? path,
    int? size,
    Duration? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return RecordingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      size: size ?? this.size,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
