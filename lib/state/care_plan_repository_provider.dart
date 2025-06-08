import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/services/fake_care_plan_repository.dart';
import 'package:nurse_os/services/care_plan_repository.dart';

final carePlanRepositoryProvider = Provider<CarePlanRepository>((ref) {
  return FakeCarePlanRepository();
});
