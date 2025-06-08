import '../models/user_model.dart';

class FakeUserService {
  UserModel _mockUser = UserModel(
    id: 'nurse123',
    firstName: 'Olivia',
    lastName: 'Ray',
    email: 'olivia@nurseos.app',
    photoUrl: '',
  );

  Future<UserModel> fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockUser;
  }

  Future<void> updateUser(UserModel updated) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockUser = updated;
  }
}