// lib/state/dashboard_filter_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardFilterState {
  final DateTime startDate;
  final DateTime endDate;

  DashboardFilterState({required this.startDate, required this.endDate});

  DashboardFilterState copyWith({DateTime? startDate, DateTime? endDate}) {
    return DashboardFilterState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class DashboardFilterNotifier extends StateNotifier<DashboardFilterState> {
  DashboardFilterNotifier()
      : super(
          DashboardFilterState(
            startDate: DateTime.now().subtract(const Duration(days: 30)),
            endDate: DateTime.now(),
          ),
        );

  void updateStart(DateTime newStart) {
    state = state.copyWith(startDate: newStart);
  }

  void updateEnd(DateTime newEnd) {
    state = state.copyWith(endDate: newEnd);
  }

  void updateRange(DateTime newStart, DateTime newEnd) {
    state = DashboardFilterState(startDate: newStart, endDate: newEnd);
  }

  void reset() {
    state = DashboardFilterState(
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now(),
    );
  }
}

final dashboardFilterProvider =
    StateNotifierProvider<DashboardFilterNotifier, DashboardFilterState>(
  (ref) => DashboardFilterNotifier(),
);
