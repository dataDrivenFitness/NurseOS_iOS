import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final fakeUserProvider = Provider<UserModel>((ref) {
  return UserModel(
    id: 'demoUser123',
    firstName: 'Carolyn',
    lastName: 'davis',
    email: 'olivia@nurseos.app',
  );
});