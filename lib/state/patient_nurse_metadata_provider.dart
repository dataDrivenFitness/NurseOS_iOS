import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_nurse_metadata_model.dart';
import 'package:nurse_os/mock_data/mock_patient_nurse_metadata_service.dart';

typedef PatientNurseMetadataRequest = ({String nurseId, String patientId});

final patientNurseMetadataProvider = FutureProvider.autoDispose
    .family<PatientNurseMetadata, PatientNurseMetadataRequest>(
  (ref, params) async {
    return MockPatientNurseMetadataService.getOrCreate(
      patientId: params.patientId,
      nurseId: params.nurseId,
    );
  },
);
