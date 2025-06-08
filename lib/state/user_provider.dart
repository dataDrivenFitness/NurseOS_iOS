import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/fake_user_service.dart';

class UserNotifier extends AsyncNotifier<UserModel> {
  final _service = FakeUserService();

  @override
  Future<UserModel> build() async {
    return _service.fetchUser();
  }

  Future<void> updateUser(UserModel user) async {
    state = const AsyncValue.loading();
    await _service.updateUser(user);
    state = AsyncValue.data(user);
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, UserModel>(() => UserNotifier());
