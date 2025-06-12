/// Global constants and typedefs for NurseOS
/// Used to streamline environment toggles and type aliasing across services.

library nurse_os.globals;

import 'package:nurse_os/repositories/patient_repository.dart';
import 'package:nurse_os/services/vitals_repository.dart';
import 'package:nurse_os/services/care_plan_repository.dart';

/// Toggle for switching between local and Firebase repositories.
const bool kUseFirebase = false;

/// Mock/test data delay used across services.
const Duration kDefaultMockDelay = Duration(milliseconds: 300);
const Duration kScenarioAdmitDelay = Duration(days: 1);

/// Demo UID constants for user and patient identities.
const String kDemoUserId = 'uid';
const String kDemoPatientId = 'patient_001';

/// Typedefs for cleaner service references and future migration safety.
typedef PatientRepo = PatientRepository;
typedef VitalsRepo = VitalsRepository;
typedef CarePlanRepo = CarePlanRepository;