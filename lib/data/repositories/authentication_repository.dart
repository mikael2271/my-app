import 'package:shared_preferences/shared_preferences.dart';

import '../api/authentication_api.dart';
import '../models/user.dart';

class AuthenticationRepository {
  AuthenticationRepository({AuthenticationApi? authenticationApi})
      : _authenticationApi = authenticationApi ?? AuthenticationApi();

  final AuthenticationApi _authenticationApi;

  /// Login for a given [email] and [password]
  /// Success: return [User]
  /// Failure: throw exception

  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    final user =
        await _authenticationApi.logIn(email: email, password: password);

    await saveUserLocally(user);

    return user;
  }

  /// Register for a given [username], [password], [confirmPassword], [email]
  /// and [cellphone]
  /// Success: return [User]
  /// Failure: throw exception

  Future<User> register({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
    required String cellphone,
  }) async {
    final user = await _authenticationApi.register(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      cellphone: cellphone,
    );

    await saveUserLocally(user);

    return user;
  }

  /// Forgot password for a given [email]
  /// Success: return token
  /// Failure: throw exception

  Future<String> forgotPassword({required String email}) async {
    return _authenticationApi.forgotPassword(email: email);
  }

  /// Change password for a given [email], [token], [digits], [password]
  /// and [confirmPassword]
  /// Success: return true
  /// Failure: throw exception

  Future<void> changePassword({
    required String email,
    required String token,
    required String digits,
    required String password,
    required String confirmPassword,
  }) async {
    await _authenticationApi.changePassword(
      email: email,
      token: token,
      digits: digits,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  /// Save [User] locally - Plugin shared_preferences

  Future<void> saveUserLocally(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', user.toJson());
  }
}
