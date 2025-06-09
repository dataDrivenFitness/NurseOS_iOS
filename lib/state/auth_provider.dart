import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/fake_auth_service.dart';

final authProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final Ref ref;
  final FakeAuthService _authService = FakeAuthService();

  AuthController({required this.ref}) : super(false); // false = not logged in

  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    state = success;
    return success;
  }

  Future<void> signOut() async {
    state = false;
    _authService.logout();
  }
}
