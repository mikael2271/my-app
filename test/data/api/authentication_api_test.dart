import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:my_app/core/exceptions/http_exception.dart';
import 'package:my_app/data/api/authentication_api.dart';
import 'package:my_app/data/models/user.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('AuthenticationApi', () {
    late http.Client httpClient;
    late AuthenticationApi authenticationApi;
    const email = 'email';
    const password = 'password';
    const username = 'username';
    const token = 'token_example';
    const digits = '7722';

    setUpAll(() {
      registerFallbackValue(FakeUri());
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      httpClient = MockHttpClient();
      authenticationApi = AuthenticationApi(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(AuthenticationApi(), isNotNull);
      });
    });

    group('logIn', () {
      test('makes correct request', () async {
        try {
          await authenticationApi.logIn(email: email, password: password);
        } catch (_) {}
        verify(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });

      test('throw error 500 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(500);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.logIn(email: email, password: password),
          throwsA(isA<ServerFailure>()),
        );
      });

      test('throw error 400 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.logIn(email: email, password: password),
          throwsA(isA<RequestFailure>()),
        );
      });

      test('returns user on valid response ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
{
  "email": "email@teste.com",
  "name": "name",
  "last_time_logged": "2020-10-10 20:00:00"
}
''');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        final user =
            await authenticationApi.logIn(email: email, password: password);
        expect(
          user,
          isA<User>()
              .having((u) => u.email, 'email', 'email@teste.com')
              .having((u) => u.name, 'name', 'name')
              .having(
                (u) => u.lastTimeLogged,
                'email',
                DateTime(2020, 10, 10, 20),
              ),
        );
      });
    });

    group('register', () {
      test('makes correct request', () async {
        try {
          await authenticationApi.register(
            username: username,
            email: email,
            password: password,
            confirmPassword: password,
          );
        } catch (_) {}
        verify(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });

      test('throw error 500 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(500);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.register(
            username: username,
            email: email,
            password: password,
            confirmPassword: password,
          ),
          throwsA(isA<ServerFailure>()),
        );
      });

      test('throw error 400 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('RequestFailure.');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.register(
            username: username,
            email: email,
            password: password,
            confirmPassword: password,
          ),
          throwsA(isA<RequestFailure>()),
        );
      });

      test('throw error email in use ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body)
            .thenReturn('The email has already been taken.');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.register(
            username: username,
            email: email,
            password: password,
            confirmPassword: password,
          ),
          throwsA(isA<AuthenticationRegisterEmailInUseFailure>()),
        );
      });

      test('returns user on valid response ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
{
  "email": "email@teste.com",
  "name": "name"
}
''');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        final user = await authenticationApi.register(
          username: username,
          email: email,
          password: password,
          confirmPassword: password,
        );
        expect(
          user,
          isA<User>()
              .having((u) => u.email, 'email', 'email@teste.com')
              .having((u) => u.name, 'name', 'name')
              .having(
                (u) => u.lastTimeLogged,
                'email',
                DateTime(2020),
              ),
        );
      });
    });
    group('forgotPassword', () {
      test('makes correct request', () async {
        try {
          await authenticationApi.forgotPassword(
            email: email,
          );
        } catch (_) {}
        verify(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });

      test('throw error 500 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(500);
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.forgotPassword(
            email: email,
          ),
          throwsA(isA<ServerFailure>()),
        );
      });

      test('throw error 400 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('RequestFailure.');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.forgotPassword(
            email: email,
          ),
          throwsA(isA<RequestFailure>()),
        );
      });

      test('returns token on valid response ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
{
  "content" : {
    "token" : "token_example"
  }
}
''');
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        final token = await authenticationApi.forgotPassword(email: email);
        expect(token, 'token_example');
      });
    });
    group('changePassword', () {
      test('makes correct request', () async {
        try {
          await authenticationApi.changePassword(
            email: email,
            token: token,
            digits: digits,
            password: password,
            confirmPassword: password,
          );
        } catch (_) {}
        verify(
          () => httpClient.put(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).called(1);
      });

      test('throw error 500 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(500);
        when(
          () => httpClient.put(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.changePassword(
            email: email,
            token: token,
            digits: digits,
            password: password,
            confirmPassword: password,
          ),
          throwsA(isA<ServerFailure>()),
        );
      });

      test('throw error 400 ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('RequestFailure.');
        when(
          () => httpClient.put(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        expect(
          () async => authenticationApi.changePassword(
            email: email,
            token: token,
            digits: digits,
            password: password,
            confirmPassword: password,
          ),
          throwsA(isA<RequestFailure>()),
        );
      });

      test('returns void on valid response ', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('');
        when(
          () => httpClient.put(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => response);
        await authenticationApi.changePassword(
          email: email,
          token: token,
          digits: digits,
          password: password,
          confirmPassword: password,
        );
        expect(response.statusCode, 200);
      });
    });
  });
}
