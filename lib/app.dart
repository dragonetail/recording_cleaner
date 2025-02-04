import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recording_cleaner/core/providers/database_provider.dart';
import 'package:recording_cleaner/core/providers/repository_provider.dart';
import 'package:recording_cleaner/core/theme/app_theme.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/pages/home_page.dart';

/// 应用程序入口
class App extends StatelessWidget {
  /// 创建[App]实例
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppLogger>(
          create: (_) => AppLogger(),
        ),
        Provider<DatabaseProvider>(
          create: (_) => DatabaseProvider(),
          dispose: (_, provider) => provider.close(),
        ),
        Provider<RepositoryProvider>(
          create: (context) => RepositoryProvider(
            logger: context.read(),
            databaseProvider: context.read(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: '录音清理',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
              ),
              useMaterial3: true,
            ),
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
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
