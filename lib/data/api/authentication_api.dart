import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';

import '../../core/exceptions/http_exception.dart';
import '../models/user.dart';
import '../services/web_service.dart';

class AuthenticationApi extends WebService {
  ///Sucesso: retorna o User
  ///Insucesso: Retorna a exceção

  Future<User> logIn({required String email, required String password}) async {
    final response = await post(
        obj: jsonEncode({
          "email": email,
          "password": password,
          "device_name": await getDeviceName()
        }),
        endpoint: '/auth/login');

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      throw RequestFailure();
    }

    try {
      return User.fromJson(response.body);
    } catch (e) {
      throw RequestFailure();
    }
  }

  /// Faz o pedido de registo na api '/auth/register'
  /// Sucesso: Retorna o user recebido
  /// Insucesso: Retorna a exceção do erro

  Future<User> register(
      {required String username,
      required String password,
      required String confirmPassword,
      required String email,
      required String cellphone}) async {
    final response = await post(
        obj: jsonEncode({
          "name": username,
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "cellphone": cellphone,
          "device_name": await getDeviceName()
        }),
        endpoint: '/auth/register');

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      if (response.body.contains("The email has already been taken.")) {
        throw AuthenticationRegisterEmailInUseFailure();
      }
      throw RequestFailure();
    }
    try {
      return User.fromJson(response.body);
    } catch (e) {
      throw RequestFailure();
    }
  }

  /// Faz o pedido de reset pw para '/auth/forgot-password'
  /// Sucesso: retorna o token recebido para envio na alteração de pw
  /// Insucesso: Retorna a exceção do erro

  Future<String> forgotPassword({required String email}) async {
    final response = await post(
        obj: jsonEncode({
          "email": email,
          "device_name": await getDeviceName(),
        }),
        endpoint: '/auth/forgot-password');

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      throw RequestFailure();
    }
    try {
      return json.decode(response.body)['content']['token'];
    } catch (e) {
      throw RequestFailure;
    }
  }

  /// Faz pedido de alteração de pw para 'auth/change-password'
  /// Sucesso: Retorna true
  /// Insucesso: Retorna a exceção do erro

  Future<void> changePassword(
      {required String email,
      required String token,
      required String digits,
      required String password,
      required String confirmPassword}) async {
    final response = await put(
        obj: jsonEncode({
          "email": email,
          "token": token,
          "digits": digits,
          "password": password,
          "password_confirmation": confirmPassword,
          "device_name": await getDeviceName()
        }),
        endpoint: '/auth/change-password');

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      throw RequestFailure();
    }
  }

  ///Devolve o nome do dispositivo - Plugin device_info
  ///No caso de não ser necessário remover o plugin

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else /*if (Platform.isIOS)*/ {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
  }
}
