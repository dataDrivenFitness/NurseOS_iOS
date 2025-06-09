// Provides mock user context using Riverpod.
// This will be swapped with Firebase auth user in a later phase.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/user_model.dart';
import 'package:nurse_os/services/mock_user_data.dart';

// A global provider to access the current nurse user
final currentUserProvider = Provider<UserModel>(
  (ref) => mockCurrentUser,
);
