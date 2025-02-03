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
      primary: Color(0xFF07C160),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFECF9F0),
      onPrimaryContainer: Color(0xFF07C160),
      secondary: Color(0xFF576B95),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFEEF2F8),
      onSecondaryContainer: Color(0xFF576B95),
      tertiary: Color(0xFFFAAD14),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFF7E6),
      onTertiaryContainer: Color(0xFFFAAD14),
      error: Color(0xFFFA5151),
      onError: Colors.white,
      errorContainer: Color(0xFFFEEFEF),
      onErrorContainer: Color(0xFFFA5151),
      background: Color(0xFFF7F7F7),
      onBackground: Color(0xFF191919),
      surface: Colors.white,
      onSurface: Color(0xFF191919),
      surfaceVariant: Color(0xFFF2F2F2),
      onSurfaceVariant: Color(0xFF767676),
      outline: Color(0xFFB2B2B2),
      outlineVariant: Color(0xFFE6E6E6),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF191919),
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFF07C160),
      surfaceTint: Color(0xFF07C160),
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      dividerColor: const Color(0xFFEEEEEE),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: GoogleFonts.notoSans(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF191919),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF191919),
        ),
      ),
    );
  }

  /// 深色主题
  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF07C160),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF1A291F),
      onPrimaryContainer: Color(0xFF07C160),
      secondary: Color(0xFF576B95),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF1C222C),
      onSecondaryContainer: Color(0xFF576B95),
      tertiary: Color(0xFFFAAD14),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFF2B2517),
      onTertiaryContainer: Color(0xFFFAAD14),
      error: Color(0xFFFA5151),
      onError: Colors.white,
      errorContainer: Color(0xFF2C1D1D),
      onErrorContainer: Color(0xFFFA5151),
      background: Color(0xFF191919),
      onBackground: Colors.white,
      surface: Color(0xFF2C2C2C),
      onSurface: Colors.white,
      surfaceVariant: Color(0xFF373737),
      onSurfaceVariant: Color(0xFFB2B2B2),
      outline: Color(0xFF767676),
      outlineVariant: Color(0xFF2C2C2C),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Color(0xFF191919),
      inversePrimary: Color(0xFF07C160),
      surfaceTint: Color(0xFF07C160),
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFF191919),
      dividerColor: const Color(0xFF373737),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF2C2C2C),
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.notoSans(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
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
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        color: colorScheme.surface,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        tileColor: colorScheme.surface,
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.primaryContainer,
        selectedColor: colorScheme.primary,
      ),
      dividerTheme: DividerThemeData(
        space: 1.h,
        thickness: 1,
        color: colorScheme.outlineVariant,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.r),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
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
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceVariant;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceVariant,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withOpacity(0.12),
        trackHeight: 2.h,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 6.r,
          elevation: 0,
          pressedElevation: 0,
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
        ),
      ),
      chipTheme: ChipThemeData(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
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
