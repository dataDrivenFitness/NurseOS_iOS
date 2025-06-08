import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/services/fake_vitals_repository.dart';
import 'package:nurse_os/services/vitals_repository.dart' as repo;

final vitalsRepositoryProvider = Provider<repo.VitalsRepository>((ref) {
  return FakeVitalsRepository();
});
