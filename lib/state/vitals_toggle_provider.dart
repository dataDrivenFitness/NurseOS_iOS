import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Future-proofed toggle provider scoped per patient
final showAllVitalsProvider = StateProvider.family<bool, String>((ref, patientId) => false);
