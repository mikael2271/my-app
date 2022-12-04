import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
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
}
