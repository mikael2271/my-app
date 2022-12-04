import 'package:shared_preferences/shared_preferences.dart';

import '../api/authentication_api.dart';
import '../models/user.dart';

class AuthenticationRepository {
  AuthenticationRepository({AuthenticationApi? authenticationApi})
      : _authenticationApi = authenticationApi ?? AuthenticationApi();

  final AuthenticationApi _authenticationApi;

  /// Recebe "email", "pw" e faz login na api
  /// Sucesso: devolve o user recebido
  /// Insucesso: throw exception

  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    User user =
        await _authenticationApi.logIn(email: email, password: password);

    await saveUserLocally(user);

    return user;
  }

  /// Recebe os dados do user e faz pedido de registo à api
  /// Sucesso: devolve o user recebido
  /// Insucesso: throw exception

  Future<User> register(
      {required String username,
      required String password,
      required String confirmPassword,
      required String email,
      required String cellphone}) async {
    User user = await _authenticationApi.register(
        username: username,
        password: password,
        confirmPassword: confirmPassword,
        email: email,
        cellphone: cellphone);

    await saveUserLocally(user);

    return user;
  }

  /// Recebe o email e faz o pedido de reset pw à api
  /// Sucesso: devolve o token recebido
  /// Insucesso: throw exception

  Future<String> forgotPassword({required String email}) async {
    return await _authenticationApi.forgotPassword(email: email);
  }

  /// Recebe email, token, digitos e nova password e faz pedido à api
  /// Sucesso: devolve true
  /// Insucesso: throw exception

  Future<void> changePassword(
      {required String email,
      required String token,
      required String digits,
      required String password,
      required String confirmPassword}) async {
    await _authenticationApi.changePassword(
        email: email,
        token: token,
        digits: digits,
        password: password,
        confirmPassword: confirmPassword);
  }

  ///Guarda os dados no dispositivo - Plugin shared_preferences
  ///No caso de não ser necessário remover o plugin

  Future<void> saveUserLocally(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user', user.toJson());
  }
}
