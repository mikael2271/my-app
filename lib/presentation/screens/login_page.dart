import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/constants/enums.dart';
import '../../logic/bloc/login_bloc.dart';
import '../../logic/error_handler.dart';
import 'widgets/custom_snackbar.dart';
import 'widgets/default_button.dart';
import 'widgets/password_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current.submissionState == SubmissionState.submissionInProgress ||
            previous.submissionState == SubmissionState.submissionInProgress,
        listener: (context, state) {
          context.loaderOverlay.hide();

          if (state.submissionState == SubmissionState.submissionInProgress) {
            context.loaderOverlay.show();
            return;
          }

          if (state.submissionState == SubmissionState.submissionSuccess) {
            //handle success

            Navigator.pushNamedAndRemoveUntil(
              context,
              'newRoute',
              (route) => false,
            );
            return;
          }

          CustomSnackbar.buildCustomSnackbar(
            context,
            SnackbarType.error,
            getStateError(context, state.submissionState, state.error),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            _PasswordInput(),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return PasswordTextField(
          hintText: AppLocalizations.of(context).email,
          errorText: null,
          onChangedHandler: (String email) {
            context.read<LoginBloc>().add(LoginEmailChanged(email));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordTextField(
          hintText: AppLocalizations.of(context).password,
          errorText: null,
          onChangedHandler: (String password) {
            context.read<LoginBloc>().add(LoginPasswordChanged(password));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.submissionState != current.submissionState,
      builder: (c, state) {
        return DefaultButton(
          AppLocalizations.of(context).enter,
          () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
        );
      },
    );
  }
}
