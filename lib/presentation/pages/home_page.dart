import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/presentation/pages/overview_page.dart';
import 'package:recording_cleaner/presentation/pages/recordings_page.dart';
import 'package:recording_cleaner/presentation/pages/calls_page.dart';
import 'package:recording_cleaner/presentation/pages/contacts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const OverviewPage(),
    const RecordingsPage(),
    const CallsPage(),
    const ContactsPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: '概览',
          ),
          NavigationDestination(
            icon: const Icon(Icons.mic_outlined),
            selectedIcon: const Icon(Icons.mic),
            label: '录音',
          ),
          NavigationDestination(
            icon: const Icon(Icons.phone_outlined),
            selectedIcon: const Icon(Icons.phone),
            label: '通话',
          ),
          NavigationDestination(
            icon: const Icon(Icons.contacts_outlined),
            selectedIcon: const Icon(Icons.contacts),
            label: '联系人',
          ),
        ],
      ),
    );
  }
}
