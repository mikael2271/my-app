import 'package:formz/formz.dart';

import '../../core/constants/enums.dart';

class ConfirmedPassword extends FormzInput<String, RulesValidationError> {
  final String password;

  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  RulesValidationError? validator(String value) {
    if (value.isEmpty) {
      return RulesValidationError.empty;
    }
    return password == value ? null : RulesValidationError.invalid;
  }
}
