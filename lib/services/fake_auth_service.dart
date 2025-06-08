class FakeAuthService {
  /// Simulates a login with fixed credentials
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return email == 'demo@nurseos.app' && password == 'demo123';
  }

  /// Simulates logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
