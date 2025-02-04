import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// 空状态组件
class EmptyState extends StatelessWidget {
  /// 创建[EmptyState]实例
  const EmptyState({
    Key? key,
    required this.message,
    this.action,
  }) : super(key: key);

  /// 提示信息
  final String message;

  /// 操作按钮
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 64.w,
            color: colorScheme.primary,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: theme.textTheme.titleLarge,
          ),
          if (action != null) ...[
            SizedBox(height: 16.h),
            action!,
          ],
        ],
      ),
    );
  }
}

/// 错误状态组件
class ErrorState extends StatelessWidget {
  /// 创建[ErrorState]实例
  const ErrorState({
    Key? key,
    this.message = '加载失败',
    this.showAnimation = true,
    this.onRetry,
  }) : super(key: key);

  /// 提示文本
  final String message;

  /// 是否显示动画
  final bool showAnimation;

  /// 重试回调
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showAnimation) ...[
            SizedBox(
              width: 200.w,
              height: 200.w,
              child: Lottie.asset(
                'assets/animations/error.json',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.h),
          ],
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.error,
                ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('点击重试'),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
