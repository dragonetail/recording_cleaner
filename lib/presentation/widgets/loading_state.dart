import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

/// 加载状态组件
class LoadingState extends StatelessWidget {
  /// 创建[LoadingState]实例
  const LoadingState({
    Key? key,
    this.message = '加载中...',
    this.showAnimation = true,
  }) : super(key: key);

  /// 提示文本
  final String message;

  /// 是否显示动画
  final bool showAnimation;

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
                'assets/animations/loading.json',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.h),
          ],
          Shimmer.fromColors(
            baseColor: colorScheme.primary.withOpacity(0.5),
            highlightColor: colorScheme.primary,
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 加载状态占位组件
class LoadingPlaceholder extends StatelessWidget {
  /// 创建[LoadingPlaceholder]实例
  const LoadingPlaceholder({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// 子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      highlightColor: Theme.of(context).colorScheme.surfaceVariant,
      child: child,
    );
  }
}

/// 加载状态占位卡片
class LoadingPlaceholderCard extends StatelessWidget {
  /// 创建[LoadingPlaceholderCard]实例
  const LoadingPlaceholderCard({
    Key? key,
    this.height,
    this.width,
    this.margin,
  }) : super(key: key);

  /// 高度
  final double? height;

  /// 宽度
  final double? width;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholder(
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

/// 加载状态占位列表项
class LoadingPlaceholderListItem extends StatelessWidget {
  /// 创建[LoadingPlaceholderListItem]实例
  const LoadingPlaceholderListItem({
    Key? key,
    this.height,
    this.margin,
  }) : super(key: key);

  /// 高度
  final double? height;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholder(
      child: Container(
        height: height ?? 72.h,
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 16.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 12.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
