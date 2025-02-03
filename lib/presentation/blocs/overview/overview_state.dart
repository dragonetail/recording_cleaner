/// 概览页面状态
///
/// 包含以下信息：
/// - 存储空间统计
/// - 各类型文件统计
/// - 加载状态

import 'package:equatable/equatable.dart';

/// 存储空间统计信息
class StorageStats extends Equatable {
  /// 总存储空间（字节）
  final int totalSpace;

  /// 已用存储空间（字节）
  final int usedSpace;

  /// 可用存储空间（字节）
  final int freeSpace;

  /// 创建[StorageStats]实例
  const StorageStats({
    required this.totalSpace,
    required this.usedSpace,
    required this.freeSpace,
  });

  @override
  List<Object?> get props => [totalSpace, usedSpace, freeSpace];
}

/// 文件统计信息
class FileStats extends Equatable {
  /// 总文件数
  final int totalCount;

  /// 总文件大小（字节）
  final int totalSize;

  /// 重要文件数
  final int importantCount;

  /// 重要文件大小（字节）
  final int importantSize;

  /// 可清理文件数
  final int cleanableCount;

  /// 可清理文件大小（字节）
  final int cleanableSize;

  /// 创建[FileStats]实例
  const FileStats({
    required this.totalCount,
    required this.totalSize,
    required this.importantCount,
    required this.importantSize,
    required this.cleanableCount,
    required this.cleanableSize,
  });

  @override
  List<Object?> get props => [
        totalCount,
        totalSize,
        importantCount,
        importantSize,
        cleanableCount,
        cleanableSize,
      ];
}

/// 概览页面状态类
class OverviewState extends Equatable {
  /// 是否正在加载
  final bool isLoading;

  /// 错误信息
  final String? error;

  /// 存储空间使用率（0-1）
  final double storageUsage;

  /// 已使用存储空间（字节）
  final int usedStorage;

  /// 总存储空间（字节）
  final int totalStorage;

  /// 录音文件数量
  final int recordingsCount;

  /// 录音文件总时长
  final Duration recordingsDuration;

  /// 录音文件总大小（字节）
  final int recordingsSize;

  /// 通话录音数量
  final int callRecordingsCount;

  /// 通话录音总时长
  final Duration callRecordingsDuration;

  /// 通话录音总大小（字节）
  final int callRecordingsSize;

  /// 创建[OverviewState]实例
  const OverviewState({
    this.isLoading = false,
    this.error,
    this.storageUsage = 0,
    this.usedStorage = 0,
    this.totalStorage = 0,
    this.recordingsCount = 0,
    this.recordingsDuration = const Duration(),
    this.recordingsSize = 0,
    this.callRecordingsCount = 0,
    this.callRecordingsDuration = const Duration(),
    this.callRecordingsSize = 0,
  });

  /// 初始状态
  factory OverviewState.initial() => const OverviewState();

  /// 加载中状态
  factory OverviewState.loading() => const OverviewState(isLoading: true);

  /// 加载失败状态
  factory OverviewState.error(String message) => OverviewState(error: message);

  /// 复制并创建新实例
  OverviewState copyWith({
    bool? isLoading,
    String? error,
    double? storageUsage,
    int? usedStorage,
    int? totalStorage,
    int? recordingsCount,
    Duration? recordingsDuration,
    int? recordingsSize,
    int? callRecordingsCount,
    Duration? callRecordingsDuration,
    int? callRecordingsSize,
  }) {
    return OverviewState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      storageUsage: storageUsage ?? this.storageUsage,
      usedStorage: usedStorage ?? this.usedStorage,
      totalStorage: totalStorage ?? this.totalStorage,
      recordingsCount: recordingsCount ?? this.recordingsCount,
      recordingsDuration: recordingsDuration ?? this.recordingsDuration,
      recordingsSize: recordingsSize ?? this.recordingsSize,
      callRecordingsCount: callRecordingsCount ?? this.callRecordingsCount,
      callRecordingsDuration:
          callRecordingsDuration ?? this.callRecordingsDuration,
      callRecordingsSize: callRecordingsSize ?? this.callRecordingsSize,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        storageUsage,
        usedStorage,
        totalStorage,
        recordingsCount,
        recordingsDuration,
        recordingsSize,
        callRecordingsCount,
        callRecordingsDuration,
        callRecordingsSize,
      ];
}
