import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/repositories/authentication_repository.dart';
import '../../logic/bloc/login_bloc.dart';
import '../screens/login_page.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BlocProvider(
            create: (context) {
              return LoginBloc(AuthenticationRepository());
            },
            child: const LoginPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                AppLocalizations.of(context).pageNotFound,
              ),
            ),
          ),
        );
    }
  }

  List<BlocProvider> getProvider() {
    return [];
  }
}
