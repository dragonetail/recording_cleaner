import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 音频波形组件
class AudioWaveform extends StatelessWidget {
  /// 创建[AudioWaveform]实例
  const AudioWaveform({
    Key? key,
    required this.samples,
    this.height = 40,
    this.width = 200,
    this.spacing = 2,
    this.barWidth = 3,
    this.color,
    this.gradient,
    this.style = PaintingStyle.fill,
    this.borderRadius,
  })  : assert(
          color != null || gradient != null,
          'color 和 gradient 必须至少指定一个',
        ),
        super(key: key);

  /// 波形数据
  final List<double> samples;

  /// 高度
  final double height;

  /// 宽度
  final double width;

  /// 间距
  final double spacing;

  /// 柱状宽度
  final double barWidth;

  /// 颜色
  final Color? color;

  /// 渐变色
  final Gradient? gradient;

  /// 绘制样式
  final PaintingStyle style;

  /// 圆角半径
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: CustomPaint(
        painter: _AudioWaveformPainter(
          samples: samples,
          color: color,
          gradient: gradient,
          style: style,
          spacing: spacing.w,
          barWidth: barWidth.w,
          borderRadius: borderRadius?.r,
        ),
      ),
    );
  }
}

class _AudioWaveformPainter extends CustomPainter {
  _AudioWaveformPainter({
    required this.samples,
    this.color,
    this.gradient,
    this.style = PaintingStyle.fill,
    this.spacing = 2,
    this.barWidth = 3,
    this.borderRadius,
  });

  final List<double> samples;
  final Color? color;
  final Gradient? gradient;
  final PaintingStyle style;
  final double spacing;
  final double barWidth;
  final double? borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.isEmpty) return;

    final paint = Paint()
      ..style = style
      ..strokeWidth = barWidth;

    if (color != null) {
      paint.color = color!;
    }

    final barCount = (size.width / (barWidth + spacing)).floor();
    final step = samples.length ~/ barCount;
    final maxAmplitude = samples.reduce(max);

    for (var i = 0; i < barCount; i++) {
      final x = i * (barWidth + spacing);
      final sampleIndex = i * step;
      if (sampleIndex >= samples.length) break;

      final amplitude = samples[sampleIndex] / maxAmplitude;
      final height = size.height * amplitude;
      final top = (size.height - height) / 2;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, top, barWidth, height),
        Radius.circular(borderRadius ?? 0),
      );

      if (gradient != null) {
        paint.shader = gradient!.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        );
      }

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AudioWaveformPainter oldDelegate) {
    return samples != oldDelegate.samples ||
        color != oldDelegate.color ||
        gradient != oldDelegate.gradient ||
        style != oldDelegate.style ||
        spacing != oldDelegate.spacing ||
        barWidth != oldDelegate.barWidth ||
        borderRadius != oldDelegate.borderRadius;
  }
}
