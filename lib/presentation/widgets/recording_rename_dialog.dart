import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordingRenameDialog extends StatefulWidget {
  final String currentName;
  final Function(String) onRename;

  const RecordingRenameDialog({
    Key? key,
    required this.currentName,
    required this.onRename,
  }) : super(key: key);

  @override
  State<RecordingRenameDialog> createState() => _RecordingRenameDialogState();
}

class _RecordingRenameDialogState extends State<RecordingRenameDialog> {
  late TextEditingController _controller;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
    _controller.addListener(_validateInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateInput() {
    final newName = _controller.text.trim();
    setState(() {
      _isValid = newName.isNotEmpty &&
          !newName.contains('/') &&
          !newName.contains('\\') &&
          newName != widget.currentName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('重命名'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: '文件名',
              errorText: !_isValid ? '请输入有效的文件名' : null,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          SizedBox(height: 8.h),
          Text(
            '不能包含 / 或 \\ 字符',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _isValid
              ? () {
                  widget.onRename(_controller.text.trim());
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('确定'),
        ),
      ],
    );
  }
}
