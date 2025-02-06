/// 录音文件实体类
///
/// 定义了录音文件的基本属性和行为。
/// 继承自[Equatable]以支持值相等性比较。
///
/// {@template recording_entity}
/// 包含录音文件的以下属性：
/// - 唯一标识符
/// - 文件名称
/// - 文件路径
/// - 文件大小
/// - 录音时长
/// - 创建时间
/// - 更新时间
/// - 删除标记
/// - 样本数据
/// {@endtemplate}

import 'package:equatable/equatable.dart';

/// 录音文件实体类
class RecordingEntity extends Equatable {
  /// 录音文件的唯一标识符
  final String id;

  /// 录音文件的名称
  final String name;

  /// 录音文件在设备上的存储路径
  final String path;

  /// 录音文件的大小（字节）
  final int size;

  /// 录音文件的时长
  final Duration duration;

  /// 录音文件的创建时间
  final DateTime createdAt;

  /// 录音文件的最后更新时间
  final DateTime updatedAt;

  /// 录音文件是否已被标记为删除
  final bool isDeleted;

  /// 录音文件的样本数据
  final List<double> samples;

  /// 创建一个[RecordingEntity]实例
  ///
  /// 所有参数除[isDeleted]外都是必需的：
  /// - [id]：文件的唯一标识符
  /// - [name]：文件名称
  /// - [path]：文件路径
  /// - [size]：文件大小（字节）
  /// - [duration]：录音时长
  /// - [createdAt]：创建时间
  /// - [updatedAt]：更新时间
  /// - [isDeleted]：删除标记，默认为false
  /// - [samples]：样本数据
  const RecordingEntity({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    required this.samples,
  });

  /// 用于[Equatable]的属性列表
  ///
  /// 包含所有影响对象相等性比较的属性
  @override
  List<Object?> get props => [
        id,
        name,
        path,
        size,
        duration,
        createdAt,
        updatedAt,
        isDeleted,
        samples,
      ];
}
