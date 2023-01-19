// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';

import '../../core/exceptions/http_exception.dart';
import '../models/user.dart';
import '../services/web_service.dart';

class AuthenticationApi extends WebService {
  /// Success: return User
  /// Failure: return exception

  Future<User> logIn({required String email, required String password}) async {
    final response = await post(
      obj: jsonEncode({
        'email': email,
        'password': password,
        'device_name': await getDeviceName()
      }),
      endpoint: '/auth/login',
    );

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

  /// Register a [User] `/auth/register`
  /// Success: return User
  /// Failure: return exception

  Future<User> register({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
    required String cellphone,
  }) async {
    final response = await post(
      obj: jsonEncode({
        'name': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'cellphone': cellphone,
        'device_name': await getDeviceName()
      }),
      endpoint: '/auth/register',
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      if (response.body.contains('The email has already been taken.')) {
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

  /// Reset password `/auth/forgot-password`
  /// Success: return token received to sent with password change
  /// Failure: return exception

  Future<String> forgotPassword({required String email}) async {
    final response = await post(
      obj: jsonEncode({
        'email': email,
        'device_name': await getDeviceName(),
      }),
      endpoint: '/auth/forgot-password',
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      throw RequestFailure();
    }
    try {
      return json.decode(response.body)['content']['token'] as String;
    } catch (e) {
      throw RequestFailure();
    }
  }

  /// Change password `auth/change-password`
  /// Success: return true
  /// Failure: return exception

  Future<void> changePassword({
    required String email,
    required String token,
    required String digits,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await put(
      obj: jsonEncode({
        'email': email,
        'token': token,
        'digits': digits,
        'password': password,
        'password_confirmation': confirmPassword,
        'device_name': await getDeviceName()
      }),
      endpoint: '/auth/change-password',
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw ServerFailure();
      }
      throw RequestFailure();
    }
  }

  /// Retrieve device name - Plugin device_info

  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else /*if (Platform.isIOS)*/ {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
  }
}
