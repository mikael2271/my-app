import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../core/constants/enums.dart';
import '../../core/exceptions/http_exception.dart';
import '../../data/models/user.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../presentation/rules/email.dart';
import '../../presentation/rules/password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }

  //Clique do botão "login"
  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(submissionState: SubmissionState.submissionInProgress));
    if (state.status.isPure) {
      emit(state.copyWith(submissionState: SubmissionState.pure));
    } else if (state.status.isInvalid) {
      emit(state.copyWith(submissionState: SubmissionState.invalid));
    } else {
      try {
        User user = await _authenticationRepository.logIn(
            email: state.email.value, password: state.password.value);
        emit(state.copyWith(
          submissionState: SubmissionState.submissionSuccess,
        ));
      } on ServerFailure {
        emit(state.copyWith(
            submissionState: SubmissionState.submissionServerError));
      } catch (_) {
        emit(
            state.copyWith(submissionState: SubmissionState.submissionFailure));
      }
    }
  }
}
