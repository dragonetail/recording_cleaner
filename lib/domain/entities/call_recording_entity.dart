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
import 'package:recording_cleaner/domain/entities/contact_entity.dart';

/// 通话类型枚举
enum CallType {
  /// 来电
  incoming,

  /// 去电
  outgoing,
}

/// 通话录音实体类
class CallRecordingEntity extends Equatable {
  /// 唯一标识符
  final String id;

  /// 文件名称
  final String name;

  /// 文件路径
  final String path;

  /// 文件大小（字节）
  final int size;

  /// 录音时长
  final Duration duration;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;

  /// 电话号码
  final String phoneNumber;

  /// 通话类型
  final CallType callType;

  /// 联系人ID
  final String contactId;

  /// 是否重要
  final bool isImportant;

  /// 是否已删除
  final bool isDeleted;

  /// 录音文件的样本数据
  final List<double> samples;

  /// 关联的联系人信息
  final ContactEntity contact;

  /// 创建一个[CallRecordingEntity]实例
  ///
  /// 除了继承自[RecordingEntity]的属性外，还需要以下参数：
  /// - [phoneNumber]：通话号码
  /// - [callType]：通话类型（来电/去电）
  /// - [contactId]：关联的联系人ID（可选）
  /// - [isImportant]：重要性标记，默认为false
  const CallRecordingEntity({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.callType,
    required this.contactId,
    this.isImportant = false,
    this.isDeleted = false,
    required this.samples,
    required this.contact,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        path,
        size,
        duration,
        createdAt,
        updatedAt,
        phoneNumber,
        callType,
        contactId,
        isImportant,
        isDeleted,
        samples,
        contact,
      ];
}
