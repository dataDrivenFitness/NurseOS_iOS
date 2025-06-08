// lib/state/user_state.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/user_model.dart';
import 'package:nurse_os/services/mock_user_data.dart';

final currentUserProvider = Provider<UserModel>((ref) => mockCurrentUser);
