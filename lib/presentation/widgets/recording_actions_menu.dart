import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recording_cleaner/domain/entities/recording_entity.dart';

class RecordingActionsMenu extends StatelessWidget {
  final RecordingEntity recording;
  final VoidCallback? onRename;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;
  final VoidCallback? onInfo;

  const RecordingActionsMenu({
    Key? key,
    required this.recording,
    this.onRename,
    this.onShare,
    this.onDelete,
    this.onInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      itemBuilder: (context) => [
        if (onRename != null)
          PopupMenuItem(
            value: 'rename',
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  size: 20.w,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SizedBox(width: 12.w),
                const Text('重命名'),
              ],
            ),
          ),
        if (onShare != null)
          PopupMenuItem(
            value: 'share',
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  size: 20.w,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SizedBox(width: 12.w),
                const Text('分享'),
              ],
            ),
          ),
        if (onInfo != null)
          PopupMenuItem(
            value: 'info',
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20.w,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SizedBox(width: 12.w),
                const Text('详细信息'),
              ],
            ),
          ),
        if (onDelete != null)
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 20.w,
                  color: Theme.of(context).colorScheme.error,
                ),
                SizedBox(width: 12.w),
                Text(
                  '删除',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'rename':
            onRename?.call();
            break;
          case 'share':
            onShare?.call();
            break;
          case 'info':
            onInfo?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
    );
  }
}
