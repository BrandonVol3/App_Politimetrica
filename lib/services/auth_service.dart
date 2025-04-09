class AuthService {
  static Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return email == 'admin@politimetrica.com' && password == '123456';
  }
}