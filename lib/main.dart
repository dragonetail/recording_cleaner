/// FlutterCleaner应用程序
///
/// 这是一个用于管理和清理录音文件的Flutter应用程序。
/// 应用采用Clean Architecture架构，使用BLoC进行状态管理。
///
/// @author blackharry
/// @version 1.0.0
/// @since 2024-03-20

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recording_cleaner/app.dart';

/// 应用程序入口函数
///
/// 负责初始化应用程序所需的所有依赖项，包括：
/// - Widget绑定初始化
/// - 音频播放器初始化
/// - 数据源和仓库的创建
/// - 用例类的实例化
/// - 测试数据的创建（仅用于开发阶段）
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置状态栏和导航栏样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  // 设置屏幕方向
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
