import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/data/api/authentication_api.dart';
import 'package:my_app/data/models/user.dart';
import 'package:my_app/data/repositories/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthenticationApi extends Mock implements AuthenticationApi {}

void main() {
  group('AuthenticationRepository', () {
    late AuthenticationApi authenticationApi;
    late AuthenticationRepository authenticationRepository;
    const email = 'email';
    const password = 'password';
    const username = 'username';
    const token = 'token_example';
    const digits = '7722';

    setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

    setUp(() {
      authenticationApi = MockAuthenticationApi();
      authenticationRepository =
          AuthenticationRepository(authenticationApi: authenticationApi);
    });

    group('constructor', () {
      test('instantiates internal Authentication api when not injected', () {
        expect(AuthenticationRepository(), isNotNull);
      });
    });

    group('logIn', () {
      test('logIn correctly', () async {
        try {
          await authenticationRepository.logIn(
            email: email,
            password: password,
          );
        } catch (_) {}
        verify(() => authenticationApi.logIn(email: email, password: password))
            .called(1);
      });
    });

    group('register', () {
      test('register correctly', () async {
        try {
          await authenticationRepository.register(
            username: username,
            email: email,
            password: password,
            confirmPassword: password,
          );
        } catch (_) {}
        verify(
          () => authenticationApi.register(
            username: username,
            email: email,
            password: password,
            confirmPassword: password,
          ),
        ).called(1);
      });
    });

    group('forgotPassword', () {
      test('forgotPassword correctly', () async {
        try {
          await authenticationRepository.forgotPassword(email: email);
        } catch (_) {}
        verify(() => authenticationApi.forgotPassword(email: email)).called(1);
      });
    });

    group('changePassword', () {
      test('changePassword correctly', () async {
        try {
          await authenticationRepository.changePassword(
            email: email,
            token: token,
            digits: digits,
            password: password,
            confirmPassword: password,
          );
        } catch (_) {}
        verify(
          () => authenticationApi.changePassword(
            email: email,
            token: token,
            digits: digits,
            password: password,
            confirmPassword: password,
          ),
        ).called(1);
      });
    });

    group('saveUserLocally', () {
      test('saveUserLocally correctly', () async {
        SharedPreferences.setMockInitialValues({});
        final sharedPreferences = await SharedPreferences.getInstance();

        await authenticationRepository.saveUserLocally(
          User(
            email: email,
            token: token,
            lastTimeLogged: DateTime(2020),
          ),
        );

        final user = User.fromJson(sharedPreferences.getString('user')!);
        expect(
          user,
          isA<User>().having((u) => u.email, 'email', email).having(
                (u) => u.lastTimeLogged,
                'lastTimeLogged',
                DateTime(2020),
              ),
        );
      });
    });
  });
}
