/// 通话录音实体类
///
/// 定义了通话录音的基本属性和行为。
/// 继承自[RecordingEntity]以复用录音文件的基本属性。
///
/// {@template call_recording_entity}
/// 除了基本的录音属性外，还包含以下通话特有属性：
/// - 通话号码
/// - 通话类型（来电/去电）
/// - 联系人ID
/// - 重要性标记
/// {@endtemplate}

import 'package:equatable/equatable.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

/// 通话类型枚举
enum CallType {
  /// 来电
  incoming,

  /// 去电
  outgoing,
}

/// 通话录音实体类
class CallRecordingEntity extends RecordingEntity {
  /// 通话号码
  final String phoneNumber;

  /// 通话类型
  final CallType callType;

  /// 关联的联系人ID
  final String? contactId;

  /// 重要性标记
  final bool isImportant;

  /// 创建一个[CallRecordingEntity]实例
  ///
  /// 除了继承自[RecordingEntity]的属性外，还需要以下参数：
  /// - [phoneNumber]：通话号码
  /// - [callType]：通话类型（来电/去电）
  /// - [contactId]：关联的联系人ID（可选）
  /// - [isImportant]：重要性标记，默认为false
  const CallRecordingEntity({
    required super.id,
    required super.name,
    required super.path,
    required super.size,
    required super.duration,
    required super.createdAt,
    required super.updatedAt,
    required this.phoneNumber,
    required this.callType,
    this.contactId,
    this.isImportant = false,
    super.isDeleted = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        phoneNumber,
        callType,
        contactId,
        isImportant,
      ];
}
