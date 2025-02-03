/// FlutterCleaner应用程序
///
/// 这是一个用于管理和清理录音文件的Flutter应用程序。
/// 应用采用Clean Architecture架构，使用BLoC进行状态管理。
///
/// @author blackharry
/// @version 1.0.0
/// @since 2024-03-20

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio/just_audio.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/data/repositories/call_recording_repository_impl.dart';
import 'package:recording_cleaner/data/repositories/recording_repository_impl.dart';
import 'package:recording_cleaner/data/sources/local_call_recording_source.dart';
import 'package:recording_cleaner/data/sources/local_recording_source.dart';
import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';
import 'package:recording_cleaner/domain/usecases/delete_recordings_usecase.dart';
import 'package:recording_cleaner/domain/usecases/get_recordings_usecase.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/pages/overview_page.dart';
import 'package:recording_cleaner/presentation/pages/recordings_page.dart';
import 'package:recording_cleaner/presentation/pages/calls_page.dart';
import 'package:recording_cleaner/presentation/pages/contacts_page.dart';

/// 应用程序入口函数
///
/// 负责初始化应用程序所需的所有依赖项，包括：
/// - Widget绑定初始化
/// - 音频播放器初始化
/// - 数据源和仓库的创建
/// - 用例类的实例化
/// - 测试数据的创建（仅用于开发阶段）
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  appLogger.i('应用启动');

  // 初始化依赖
  final audioPlayer = AudioPlayer();
  final recordingSource = LocalRecordingSource(
    logger: appLogger,
    audioPlayer: audioPlayer,
  );
  final callRecordingSource = LocalCallRecordingSource(
    logger: appLogger,
    audioPlayer: audioPlayer,
  );
  final recordingRepository = RecordingRepositoryImpl(recordingSource);
  final callRecordingRepository =
      CallRecordingRepositoryImpl(callRecordingSource);
  final getRecordingsUseCase = GetRecordingsUseCase(recordingRepository);
  final deleteRecordingsUseCase = DeleteRecordingsUseCase(recordingRepository);

  // 创建测试数据
  await recordingSource.createTestData();
  await callRecordingSource.createTestData();

  runApp(MyApp(
    repository: recordingRepository,
    callRecordingRepository: callRecordingRepository,
    getRecordingsUseCase: getRecordingsUseCase,
    deleteRecordingsUseCase: deleteRecordingsUseCase,
  ));
}

/// 应用程序根Widget
///
/// 负责配置和初始化应用程序的全局设置，包括：
/// - BLoC提供者的配置
/// - 屏幕适配的设置
/// - 主题的配置
/// - 本地化的设置
///
/// {@template my_app}
/// 使用[MultiBlocProvider]提供全局状态管理
/// 使用[ScreenUtilInit]处理屏幕适配
/// 使用[MaterialApp]配置应用程序的基本属性
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// 录音文件仓库接口
  final RecordingRepository repository;

  /// 通话录音仓库接口
  final CallRecordingRepository callRecordingRepository;

  /// 获取录音文件用例
  final GetRecordingsUseCase getRecordingsUseCase;

  /// 删除录音文件用例
  final DeleteRecordingsUseCase deleteRecordingsUseCase;

  const MyApp({
    super.key,
    required this.repository,
    required this.callRecordingRepository,
    required this.getRecordingsUseCase,
    required this.deleteRecordingsUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'FlutterCleaner',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CN'),
          ],
          home: child,
        );
      },
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<RecordingRepository>(
            create: (context) => repository,
          ),
          RepositoryProvider<CallRecordingRepository>(
            create: (context) => callRecordingRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RecordingsBloc>(
              create: (context) => RecordingsBloc(
                getRecordings: getRecordingsUseCase,
                deleteRecordings: deleteRecordingsUseCase,
                repository: repository,
              )..add(const LoadRecordings()),
            ),
          ],
          child: const MainPage(),
        ),
      ),
    );
  }
}

/// 主页面Widget
///
/// 使用[IndexedStack]和[NavigationBar]实现底部导航
/// 包含四个主要页面：
/// - 概览页面
/// - 录音页面
/// - 通话页面
/// - 联系人页面
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

/// 主页面状态类
///
/// 管理底部导航栏的状态和页面切换
class _MainPageState extends State<MainPage> {
  /// 当前选中的导航项索引
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          OverviewPage(),
          RecordingsPage(),
          CallsPage(),
          ContactsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '概览',
          ),
          NavigationDestination(
            icon: Icon(Icons.mic_outlined),
            selectedIcon: Icon(Icons.mic),
            label: '录音',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call),
            label: '通话',
          ),
          NavigationDestination(
            icon: Icon(Icons.contacts_outlined),
            selectedIcon: Icon(Icons.contacts),
            label: '联系人',
          ),
        ],
      ),
    );
  }
}
