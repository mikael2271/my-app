part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.submissionState = SubmissionState.empty,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  final FormzStatus status;
  final SubmissionState submissionState;
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
    Email? email,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      submissionState: submissionState ?? this.submissionState,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginInitial extends LoginState {}
