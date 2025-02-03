import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordingFilterDialog extends StatefulWidget {
  final String? timeFilter;
  final String? durationFilter;
  final String? sortBy;
  final bool? ascending;
  final Function(String?, String?, String?, bool?) onApply;

  const RecordingFilterDialog({
    Key? key,
    this.timeFilter,
    this.durationFilter,
    this.sortBy,
    this.ascending,
    required this.onApply,
  }) : super(key: key);

  @override
  State<RecordingFilterDialog> createState() => _RecordingFilterDialogState();
}

class _RecordingFilterDialogState extends State<RecordingFilterDialog> {
  late String? _timeFilter;
  late String? _durationFilter;
  late String? _sortBy;
  late bool? _ascending;

  @override
  void initState() {
    super.initState();
    _timeFilter = widget.timeFilter;
    _durationFilter = widget.durationFilter;
    _sortBy = widget.sortBy;
    _ascending = widget.ascending;
  }

  Widget _buildTimeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '时间筛选',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          children: [
            ChoiceChip(
              label: const Text('全部'),
              selected: _timeFilter == null,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _timeFilter = null);
                }
              },
            ),
            ChoiceChip(
              label: const Text('一年以前'),
              selected: _timeFilter == 'time_year',
              onSelected: (selected) {
                setState(() => _timeFilter = selected ? 'time_year' : null);
              },
            ),
            ChoiceChip(
              label: const Text('90天以前'),
              selected: _timeFilter == 'time_90days',
              onSelected: (selected) {
                setState(() => _timeFilter = selected ? 'time_90days' : null);
              },
            ),
            ChoiceChip(
              label: const Text('最近90天'),
              selected: _timeFilter == 'time_recent',
              onSelected: (selected) {
                setState(() => _timeFilter = selected ? 'time_recent' : null);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '时长筛选',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          children: [
            ChoiceChip(
              label: const Text('全部'),
              selected: _durationFilter == null,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _durationFilter = null);
                }
              },
            ),
            ChoiceChip(
              label: const Text('2小时以上'),
              selected: _durationFilter == 'duration_2h',
              onSelected: (selected) {
                setState(
                    () => _durationFilter = selected ? 'duration_2h' : null);
              },
            ),
            ChoiceChip(
              label: const Text('10分钟以上'),
              selected: _durationFilter == 'duration_10m',
              onSelected: (selected) {
                setState(
                    () => _durationFilter = selected ? 'duration_10m' : null);
              },
            ),
            ChoiceChip(
              label: const Text('10分钟以内'),
              selected: _durationFilter == 'duration_under10m',
              onSelected: (selected) {
                setState(() =>
                    _durationFilter = selected ? 'duration_under10m' : null);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '排序方式',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          children: [
            ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('时间'),
                  if (_sortBy == 'time')
                    Icon(
                      _ascending == true
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16.w,
                    ),
                ],
              ),
              selected: _sortBy == 'time',
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _sortBy = 'time';
                    _ascending ??= false;
                  } else {
                    _sortBy = null;
                    _ascending = null;
                  }
                });
              },
            ),
            ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('大小'),
                  if (_sortBy == 'size')
                    Icon(
                      _ascending == true
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16.w,
                    ),
                ],
              ),
              selected: _sortBy == 'size',
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _sortBy = 'size';
                    _ascending ??= false;
                  } else {
                    _sortBy = null;
                    _ascending = null;
                  }
                });
              },
            ),
            if (_sortBy != null)
              IconButton(
                icon: Icon(
                  _ascending == true
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                ),
                onPressed: () {
                  setState(() => _ascending = !(_ascending ?? false));
                },
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '筛选',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildTimeFilter(),
            SizedBox(height: 16.h),
            _buildDurationFilter(),
            SizedBox(height: 16.h),
            _buildSortOptions(),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _timeFilter = null;
                      _durationFilter = null;
                      _sortBy = null;
                      _ascending = null;
                    });
                  },
                  child: const Text('重置'),
                ),
                SizedBox(width: 8.w),
                FilledButton(
                  onPressed: () {
                    widget.onApply(
                      _timeFilter,
                      _durationFilter,
                      _sortBy,
                      _ascending,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('应用'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
