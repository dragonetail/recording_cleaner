import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/core/theme/app_theme.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/data/repositories/call_recording_repository_impl.dart';
import 'package:recording_cleaner/data/repositories/recording_repository_impl.dart';
import 'package:recording_cleaner/domain/repositories/call_recording_repository.dart';
import 'package:recording_cleaner/domain/repositories/recording_repository.dart';
import 'package:recording_cleaner/domain/usecases/delete_recordings_usecase.dart';
import 'package:recording_cleaner/domain/usecases/get_recordings_usecase.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/pages/home_page.dart';

/// 应用程序入口Widget
class App extends StatelessWidget {
  /// 创建[App]实例
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化仓库
    final recordingRepository = RecordingRepositoryImpl();
    final callRecordingRepository = CallRecordingRepositoryImpl();

    // 初始化用例
    final getRecordingsUseCase = GetRecordingsUseCase(recordingRepository);
    final deleteRecordingsUseCase =
        DeleteRecordingsUseCase(recordingRepository);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Recording Cleaner',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'),
        ],
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AppLogger>(
              create: (context) => logger,
            ),
            RepositoryProvider<RecordingRepository>(
              create: (context) => recordingRepository,
            ),
            RepositoryProvider<CallRecordingRepository>(
              create: (context) => callRecordingRepository,
            ),
            RepositoryProvider<GetRecordingsUseCase>(
              create: (context) => getRecordingsUseCase,
            ),
            RepositoryProvider<DeleteRecordingsUseCase>(
              create: (context) => deleteRecordingsUseCase,
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RecordingsBloc>(
                create: (context) => RecordingsBloc(
                  logger: context.read<AppLogger>(),
                  getRecordings: context.read<GetRecordingsUseCase>(),
                  deleteRecordings: context.read<DeleteRecordingsUseCase>(),
                  recordingRepository: context.read<RecordingRepository>(),
                )..add(const LoadRecordings()),
              ),
            ],
            child: const HomePage(),
          ),
        ),
      ),
    );
  }
}

/// 主页面Widget
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

/// 主页面状态类
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
