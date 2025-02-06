import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('联系人'),
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
                  color: theme.colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.person,
                  color: theme.colorScheme.onTertiaryContainer,
                ),
              ),
              title: Text('联系人 ${index + 1}'),
              subtitle: Text('138 0013 800${index}'),
              trailing: IconButton(
                onPressed: () {
                  // TODO: 实现更多操作
                },
                icon: const Icon(Icons.more_vert),
              ),
              onTap: () {
                // TODO: 实现联系人详情页面
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现添加联系人功能
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
