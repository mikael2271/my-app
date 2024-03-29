// Receive a state and retrieve String translated
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/constants/enums.dart';

String getStateError(
  BuildContext context,
  SubmissionState status,
  String? error,
) {
  switch (status) {
    case SubmissionState.pure:
      return AppLocalizations.of(context).fieldsRequired;

    case SubmissionState.invalid:
      return AppLocalizations.of(context).fieldsInvalid;

    case SubmissionState.submissionFailure:
      return AppLocalizations.of(context).fieldsIncorrect;

    case SubmissionState.submissionServerError:
      return AppLocalizations.of(context).serverError;

    case SubmissionState.custom:
      return getDynamicTranslations(context, error);
  }
  return AppLocalizations.of(context).defaultError;
}

String getDynamicTranslations(BuildContext context, String? error) {
  switch (error) {
    case 'emailInUse':
      return AppLocalizations.of(context).emailInUse;
    default:
      return AppLocalizations.of(context).defaultError;
  }
}
