import 'package:food_dashboard/datasources/model/userModel.dart';

abstract class IAuthService {
  Future<UserModel?> signIn({
    required String username,
    required String password,
  });
  Future<String> signUp({
    required String username,
    required String email,
    required String password,
  });
}
