// lib/services/mock_patient_data.dart

import 'package:nurse_os/models/patient_model.dart';

final mockPatients = <PatientModel>[
  PatientModel(
    id: 'p001',
    firstName: 'Alex',
    lastName: 'Rivera',
    age: 45,
    roomNumber: '302B',
    diagnosis: 'Hypertension',
    admittedAt: DateTime.now().subtract(Duration(days: 2)),
    pronouns: 'they/them',
    photoUrl: 'https://randomuser.me/api/portraits/med/men/32.jpg',
  ),
  PatientModel(
    id: 'p002',
    firstName: 'Jordan',
    lastName: 'Nguyen',
    age: 36,
    roomNumber: '110A',
    diagnosis: 'Post-op recovery',
    admittedAt: DateTime.now().subtract(Duration(hours: 18)),
    pronouns: 'she/her',
    photoUrl: 'https://randomuser.me/api/portraits/med/women/45.jpg',
  ),
  PatientModel(
    id: 'p003',
    firstName: 'Morgan',
    lastName: 'Chen',
    age: 29,
    roomNumber: '208C',
    diagnosis: 'Asthma',
    admittedAt: DateTime.now().subtract(Duration(days: 1, hours: 3)),
    pronouns: 'he/him',
    photoUrl: 'https://randomuser.me/api/portraits/med/men/77.jpg',
  ),
];
