// lib/widgets/date_range_picker_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/dashboard_filter_provider.dart';

class DateRangePickerWidget extends ConsumerWidget {
  final bool showLabel;

  const DateRangePickerWidget({super.key, this.showLabel = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(dashboardFilterProvider);
    final notifier = ref.read(dashboardFilterProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          const Text('Filter by Date Range', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
        ],
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    initialDateRange: DateTimeRange(
                      start: range.startDate,
                      end: range.endDate,
                    ),
                  );
                  if (picked != null) {
                    notifier.updateRange(picked.start, picked.end);
                  }
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '${_formatDate(range.startDate)} – ${_formatDate(range.endDate)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Reset to Last 30 Days',
              onPressed: notifier.reset,
            )
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
