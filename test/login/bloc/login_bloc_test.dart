import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/core/constants/enums.dart';
import 'package:my_app/data/models/user.dart';
import 'package:my_app/data/repositories/authentication_repository.dart';
import 'package:my_app/logic/bloc/login_bloc.dart';
import 'package:my_app/presentation/rules/email.dart';
import 'package:my_app/presentation/rules/password.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('LoginBloc', () {
    test('initial state is LoginState', () {
      final loginBloc = LoginBloc(
        authenticationRepository,
      );
      expect(loginBloc.state, const LoginState());
    });
  });

  group('LoginSubmitted', () {
    blocTest<LoginBloc, LoginState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when login succeeds',
      setUp: () {
        when(
          () => authenticationRepository.logIn(
            email: 'email@teste.com',
            password: 'password123!',
          ),
        ).thenAnswer(
          (_) => Future<User>.value(
            User(
              email: 'email@teste.com',
              lastTimeLogged: DateTime.now(),
            ),
          ),
        );
      },
      build: () => LoginBloc(
        authenticationRepository,
      ),
      act: (bloc) {
        bloc
          ..add(const LoginEmailChanged('email@teste.com'))
          ..add(const LoginPasswordChanged('password123!'))
          ..add(const LoginSubmitted());
      },
      expect: () => const <LoginState>[
        LoginState(
          email: Email.dirty('email@teste.com'),
          status: FormzStatus.invalid,
        ),
        LoginState(
          email: Email.dirty('email@teste.com'),
          password: Password.dirty('password123!'),
          status: FormzStatus.valid,
        ),
        LoginState(
          email: Email.dirty('email@teste.com'),
          password: Password.dirty('password123!'),
          status: FormzStatus.valid,
          submissionState: SubmissionState.submissionInProgress,
        ),
        LoginState(
          email: Email.dirty('email@teste.com'),
          password: Password.dirty('password123!'),
          status: FormzStatus.valid,
          submissionState: SubmissionState.submissionSuccess,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure] when logIn fails',
      setUp: () {
        when(
          () => authenticationRepository.logIn(
            email: 'email@teste.com',
            password: 'password123!',
          ),
        ).thenThrow('fail');
      },
      build: () => LoginBloc(
        authenticationRepository,
      ),
      act: (bloc) {
        bloc
          ..add(const LoginEmailChanged('email@teste.com'))
          ..add(const LoginPasswordChanged('password123!'))
          ..add(const LoginSubmitted());
      },
      expect: () => const <LoginState>[
        LoginState(
          email: Email.dirty('email@teste.com'),
          status: FormzStatus.invalid,
        ),
        LoginState(
          email: Email.dirty('email@teste.com'),
          password: Password.dirty('password123!'),
          status: FormzStatus.valid,
        ),
        LoginState(
          email: Email.dirty('email@teste.com'),
          password: Password.dirty('password123!'),
          status: FormzStatus.valid,
          submissionState: SubmissionState.submissionInProgress,
        ),
        LoginState(
          email: Email.dirty('email@teste.com'),
          password: Password.dirty('password123!'),
          status: FormzStatus.valid,
          submissionState: SubmissionState.submissionFailure,
        ),
      ],
    );
  });
}
