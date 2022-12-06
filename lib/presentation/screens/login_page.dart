import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../logic/bloc/login_bloc.dart';
import 'widgets/default_button.dart';
import 'widgets/password_textfield.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
