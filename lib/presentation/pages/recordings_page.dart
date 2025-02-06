import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recording_cleaner/core/constants/app_constants.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_bloc.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_event.dart';
import 'package:recording_cleaner/presentation/blocs/recordings/recordings_state.dart';
import 'package:recording_cleaner/presentation/widgets/empty_state.dart';
import 'package:recording_cleaner/presentation/widgets/loading_state.dart';
import 'package:recording_cleaner/presentation/widgets/recording_list_item.dart';
import 'package:recording_cleaner/presentation/widgets/selection_mode.dart';

/// 录音列表页面
class RecordingsPage extends StatelessWidget {
  /// 创建[RecordingsPage]实例
  const RecordingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('录音'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: 实现搜索功能
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // TODO: 实现筛选功能
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 4.h,
            ),
            child: ListTile(
              leading: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.mic,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text('录音 ${index + 1}'),
              subtitle: Text('2024-03-${10 + index} 10:00'),
              trailing: Text('${5 + index}分钟'),
              onTap: () {
                // TODO: 实现录音详情页面
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现录音功能
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
