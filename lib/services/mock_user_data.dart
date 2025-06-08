// lib/services/mock_user_data.dart

import 'package:nurse_os/models/user_model.dart';

final mockCurrentUser = UserModel(
  id: 'u123',
  firstName: 'Avery',
  lastName: 'Kim',
  email: 'avery.kim@nurseos.app', // ✅ Add this
  photoUrl: 'https://randomuser.me/api/portraits/med/people/29.jpg',
  xp: 120,
  level: 2,
);

