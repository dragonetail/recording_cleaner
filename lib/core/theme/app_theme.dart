import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// 应用主题配置
class AppTheme {
  /// 禁止实例化
  AppTheme._();

  /// 浅色主题
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF07C160),
      onPrimary: Colors.white,
      secondary: Color(0xFF576B95),
      onSecondary: Colors.white,
      error: Color(0xFFFA5151),
      onError: Colors.white,
      background: Color(0xFFF7F7F7),
      onBackground: Color(0xFF191919),
      surface: Colors.white,
      onSurface: Color(0xFF191919),
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      dividerColor: const Color(0xFFEEEEEE),
    );
  }

  /// 深色主题
  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF07C160),
      onPrimary: Colors.white,
      secondary: Color(0xFF576B95),
      onSecondary: Colors.white,
      error: Color(0xFFFA5151),
      onError: Colors.white,
      background: Color(0xFF191919),
      onBackground: Colors.white,
      surface: Color(0xFF2C2C2C),
      onSurface: Colors.white,
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFF191919),
      dividerColor: const Color(0xFF373737),
    );
  }

  /// 基础主题配置
  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final textTheme = _buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      dividerTheme: DividerThemeData(
        space: 1.h,
        thickness: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.r),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  /// 构建文字主题
  static TextTheme _buildTextTheme() {
    return GoogleFonts.notoSansTextTheme().copyWith(
      displayLarge: TextStyle(fontSize: 32.sp),
      displayMedium: TextStyle(fontSize: 28.sp),
      displaySmall: TextStyle(fontSize: 24.sp),
      headlineLarge: TextStyle(fontSize: 22.sp),
      headlineMedium: TextStyle(fontSize: 20.sp),
      headlineSmall: TextStyle(fontSize: 18.sp),
      titleLarge: TextStyle(fontSize: 17.sp),
      titleMedium: TextStyle(fontSize: 16.sp),
      titleSmall: TextStyle(fontSize: 15.sp),
      bodyLarge: TextStyle(fontSize: 15.sp),
      bodyMedium: TextStyle(fontSize: 14.sp),
      bodySmall: TextStyle(fontSize: 13.sp),
      labelLarge: TextStyle(fontSize: 14.sp),
      labelMedium: TextStyle(fontSize: 13.sp),
      labelSmall: TextStyle(fontSize: 12.sp),
    );
  }

  /// 卡片阴影
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8.r,
          offset: Offset(0, 2.h),
        ),
      ];
}
