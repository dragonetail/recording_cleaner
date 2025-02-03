import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';

/// 应用工具类
class AppUtils {
  /// 禁止实例化
  AppUtils._();

  /// 格式化文件大小
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';

    int index = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && index < AppConstants.maxFileSizeUnit.length - 1) {
      size /= 1024;
      index++;
    }

    return '${size.toStringAsFixed(AppConstants.fileSizeDecimalPlaces)} ${AppConstants.maxFileSizeUnit[index]}';
  }

  /// 格式化时长
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours =
        duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours$minutes:$seconds';
  }

  /// 格式化日期
  static String formatDate(DateTime date) {
    return DateFormat(AppConstants.dateFormat).format(date);
  }

  /// 格式化时间
  static String formatTime(DateTime time) {
    return DateFormat(AppConstants.timeFormat).format(time);
  }

  /// 格式化日期时间
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.dateTimeFormat).format(dateTime);
  }

  /// 格式化百分比
  static String formatPercentage(double percentage) {
    return '${(percentage * 100).toStringAsFixed(AppConstants.percentageDecimalPlaces)}%';
  }

  /// 获取存储空间使用状态颜色
  static Color getStorageStatusColor(BuildContext context, double usage) {
    final colorScheme = Theme.of(context).colorScheme;
    if (usage >= AppConstants.storageWarningThreshold) {
      return colorScheme.error;
    } else if (usage >= AppConstants.storageCautionThreshold) {
      return colorScheme.tertiary;
    }
    return colorScheme.primary;
  }

  /// 触感反馈
  static Future<void> vibrate() async {
    if (await Vibrate.canVibrate) {
      Vibrate.feedback(FeedbackType.light);
    }
  }

  /// 显示提示
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? colorScheme.error : colorScheme.primaryContainer,
        duration: AppConstants.snackBarDuration,
      ),
    );
  }

  /// 显示确认对话框
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String? cancelText,
    String? confirmText,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText ?? '取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText ?? '确认',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 显示底部菜单
  static Future<T?> showBottomSheet<T>(
    BuildContext context,
    Widget child,
  ) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => child,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}
