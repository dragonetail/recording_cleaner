import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/presentation/pages/overview_page.dart';

/// 主页面
class HomePage extends StatefulWidget {
  /// 创建[HomePage]实例
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 当前页面索引
  int _currentIndex = 0;

  /// 页面列表
  final List<Widget> _pages = [
    const OverviewPage(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: 24.w,
            ),
            selectedIcon: Icon(
              Icons.home_rounded,
              size: 24.w,
            ),
            label: '概览',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.mic_outlined,
              size: 24.w,
            ),
            selectedIcon: Icon(
              Icons.mic_rounded,
              size: 24.w,
            ),
            label: '录音',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.call_outlined,
              size: 24.w,
            ),
            selectedIcon: Icon(
              Icons.call_rounded,
              size: 24.w,
            ),
            label: '通话',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.contacts_outlined,
              size: 24.w,
            ),
            selectedIcon: Icon(
              Icons.contacts_rounded,
              size: 24.w,
            ),
            label: '联系人',
          ),
        ],
      ),
    );
  }
}
