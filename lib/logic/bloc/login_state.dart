part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.submissionState = SubmissionState.empty,
    this.error,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final SubmissionState submissionState;
  final String? error;
  final Email email;
  final Password password;

  @override
  List<Object> get props => [
        status,
        submissionState,
        email,
        password,
      ];

  LoginState copyWith({
    FormzStatus? status,
    SubmissionState? submissionState,
    String? error,
    Email? email,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      submissionState: submissionState ?? this.submissionState,
      error: error ?? this.error,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
