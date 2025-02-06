import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      primary: Color(0xFF007AFF), // iOS蓝色
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE5F1FF),
      onPrimaryContainer: Color(0xFF007AFF),
      secondary: Color(0xFF5856D6), // iOS紫色
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFEEEEFF),
      onSecondaryContainer: Color(0xFF5856D6),
      tertiary: Color(0xFFFF9500), // iOS橙色
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFEFD6),
      onTertiaryContainer: Color(0xFFFF9500),
      error: Color(0xFFFF3B30), // iOS红色
      onError: Colors.white,
      errorContainer: Color(0xFFFFE5E5),
      onErrorContainer: Color(0xFFFF3B30),
      background: Color(0xFFF2F2F7), // iOS背景色
      onBackground: Color(0xFF000000),
      surface: Colors.white,
      onSurface: Color(0xFF000000),
      surfaceVariant: Color(0xFFF7F7F7),
      onSurfaceVariant: Color(0xFF8E8E93), // iOS次要文本色
      outline: Color(0xFFC5C5C7), // iOS分割线颜色
      outlineVariant: Color(0xFFE5E5EA),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF000000),
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFF007AFF),
      surfaceTint: Color(0xFF007AFF),
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      dividerColor: const Color(0xFFC5C5C7),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: GoogleFonts.notoSans(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF000000),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF007AFF),
        ),
      ),
    );
  }

  /// 深色主题
  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF0A84FF), // iOS深色模式蓝色
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF1C1C1E),
      onPrimaryContainer: Color(0xFF0A84FF),
      secondary: Color(0xFF5E5CE6), // iOS深色模式紫色
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF1C1C1E),
      onSecondaryContainer: Color(0xFF5E5CE6),
      tertiary: Color(0xFFFF9F0A), // iOS深色模式橙色
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFF1C1C1E),
      onTertiaryContainer: Color(0xFFFF9F0A),
      error: Color(0xFFFF453A), // iOS深色模式红色
      onError: Colors.white,
      errorContainer: Color(0xFF1C1C1E),
      onErrorContainer: Color(0xFFFF453A),
      background: Color(0xFF000000), // iOS深色模式背景色
      onBackground: Colors.white,
      surface: Color(0xFF1C1C1E), // iOS深色模式表面色
      onSurface: Colors.white,
      surfaceVariant: Color(0xFF2C2C2E),
      onSurfaceVariant: Color(0xFF8E8E93),
      outline: Color(0xFF48484A),
      outlineVariant: Color(0xFF3A3A3C),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Color(0xFF000000),
      inversePrimary: Color(0xFF0A84FF),
      surfaceTint: Color(0xFF0A84FF),
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFF000000),
      dividerColor: const Color(0xFF48484A),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF1C1C1E),
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.notoSans(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF0A84FF),
        ),
      ),
    );
  }

  /// 基础主题配置
  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final textTheme = _buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      typography: Typography.material2021(platform: TargetPlatform.iOS),
      scaffoldBackgroundColor: colorScheme.background,
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        color: colorScheme.surface,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        tileColor: colorScheme.surface,
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.primaryContainer,
        selectedColor: colorScheme.primary,
      ),
      dividerTheme: DividerThemeData(
        space: 0,
        thickness: 0.5,
        color: colorScheme.outline,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.r),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        side: BorderSide(
          color: colorScheme.outline,
          width: 1.5,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceVariant,
        thumbColor: Colors.white,
        overlayColor: colorScheme.primary.withOpacity(0.12),
        trackHeight: 2.h,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 6.r,
          elevation: 2,
          pressedElevation: 4,
        ),
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: 16.r,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          foregroundColor: colorScheme.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          side: BorderSide(
            color: colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          padding: EdgeInsets.all(8.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          foregroundColor: colorScheme.primary,
        ),
      ),
      chipTheme: ChipThemeData(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        side: BorderSide.none,
        backgroundColor: colorScheme.surfaceVariant,
        labelStyle: textTheme.labelMedium,
        iconTheme: IconThemeData(
          size: 18.w,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: colorScheme.error,
        textColor: colorScheme.onError,
        smallSize: 8.w,
        largeSize: 16.w,
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.all(16.w),
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: textTheme.labelSmall,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 60.h,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
            );
          }
          return textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              size: 24.w,
              color: colorScheme.primary,
            );
          }
          return IconThemeData(
            size: 24.w,
            color: colorScheme.onSurfaceVariant,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        selectedIconTheme: IconThemeData(
          size: 24.w,
          color: colorScheme.primary,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24.w,
          color: colorScheme.onSurfaceVariant,
        ),
        selectedLabelTextStyle: textTheme.labelSmall?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelTextStyle: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: textTheme.labelLarge,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),
    );
  }

  /// 构建文字主题
  static TextTheme _buildTextTheme() {
    return GoogleFonts.notoSansTextTheme().copyWith(
      displayLarge: TextStyle(fontSize: 34.sp, letterSpacing: 0.37),
      displayMedium: TextStyle(fontSize: 28.sp, letterSpacing: 0.36),
      displaySmall: TextStyle(fontSize: 24.sp, letterSpacing: 0.35),
      headlineLarge: TextStyle(fontSize: 22.sp, letterSpacing: 0.35),
      headlineMedium: TextStyle(fontSize: 20.sp, letterSpacing: 0.35),
      headlineSmall: TextStyle(fontSize: 17.sp, letterSpacing: -0.41),
      titleLarge: TextStyle(fontSize: 17.sp, letterSpacing: -0.41),
      titleMedium: TextStyle(fontSize: 16.sp, letterSpacing: -0.32),
      titleSmall: TextStyle(fontSize: 15.sp, letterSpacing: -0.24),
      bodyLarge: TextStyle(fontSize: 17.sp, letterSpacing: -0.41),
      bodyMedium: TextStyle(fontSize: 15.sp, letterSpacing: -0.24),
      bodySmall: TextStyle(fontSize: 13.sp, letterSpacing: -0.08),
      labelLarge: TextStyle(fontSize: 13.sp, letterSpacing: -0.08),
      labelMedium: TextStyle(fontSize: 12.sp, letterSpacing: 0),
      labelSmall: TextStyle(fontSize: 11.sp, letterSpacing: 0.06),
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
