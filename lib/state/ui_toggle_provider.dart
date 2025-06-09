// lib/state/ui_toggle_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showAllCarePlansProvider = StateProvider.family<bool, String>((ref, patientId) => false);
final showAllNotesProvider = StateProvider.family<bool, String>((ref, patientId) => false);
