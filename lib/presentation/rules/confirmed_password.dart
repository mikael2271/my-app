import 'package:formz/formz.dart';

import '../../core/constants/enums.dart';

class ConfirmedPassword extends FormzInput<String, RulesValidationError> {
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  final String password;

  @override
  RulesValidationError? validator(String value) {
    if (value.isEmpty) {
      return RulesValidationError.empty;
    }
    return password == value ? null : RulesValidationError.invalid;
  }
}
