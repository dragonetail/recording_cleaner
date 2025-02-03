/// 通话录音数据模型
///
/// 继承自[CallRecordingEntity]，用于数据层的通话录音数据处理。
/// 提供JSON序列化和反序列化功能。

import 'package:recording_cleaner/domain/entities/call_recording_entity.dart';

/// 通话录音数据模型
class CallRecordingModel extends CallRecordingEntity {
  /// 创建[CallRecordingModel]实例
  const CallRecordingModel({
    required super.id,
    required super.name,
    required super.path,
    required super.size,
    required super.duration,
    required super.createdAt,
    required super.updatedAt,
    required super.phoneNumber,
    required super.callType,
    required super.contactId,
    super.isImportant = false,
    super.isDeleted = false,
  });

  /// 从JSON映射创建[CallRecordingModel]实例
  factory CallRecordingModel.fromJson(Map<String, dynamic> json) {
    return CallRecordingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      size: json['size'] as int,
      duration: Duration(milliseconds: json['duration'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      phoneNumber: json['phoneNumber'] as String,
      callType: CallType.values[json['callType'] as int],
      contactId: json['contactId'] as String?,
      isImportant: json['isImportant'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  /// 将[CallRecordingModel]转换为JSON映射
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'size': size,
      'duration': duration.inMilliseconds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'callType': callType.index,
      'contactId': contactId,
      'isImportant': isImportant,
      'isDeleted': isDeleted,
    };
  }

  /// 从实体创建模型
  factory CallRecordingModel.fromEntity(CallRecordingEntity entity) {
    return CallRecordingModel(
      id: entity.id,
      name: entity.name,
      path: entity.path,
      size: entity.size,
      duration: entity.duration,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      phoneNumber: entity.phoneNumber,
      callType: entity.callType,
      contactId: entity.contactId,
      isImportant: entity.isImportant,
      isDeleted: entity.isDeleted,
    );
  }

  /// 复制并创建新实例
  CallRecordingModel copyWith({
    String? id,
    String? name,
    String? path,
    int? size,
    Duration? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? phoneNumber,
    CallType? callType,
    String? contactId,
    bool? isImportant,
    bool? isDeleted,
  }) {
    return CallRecordingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      size: size ?? this.size,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      callType: callType ?? this.callType,
      contactId: contactId ?? this.contactId,
      isImportant: isImportant ?? this.isImportant,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
