import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('通话'),
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
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.phone,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              title: Text('联系人 ${index + 1}'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.call_made,
                    size: 16.w,
                    color: theme.colorScheme.secondary,
                  ),
                  SizedBox(width: 4.w),
                  Text('2024-03-${10 + index} 11:00'),
                ],
              ),
              trailing: Text('${3 + index}分钟'),
              onTap: () {
                // TODO: 实现通话详情页面
              },
            ),
          );
        },
      ),
    );
  }
}
