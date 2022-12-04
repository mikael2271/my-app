import 'package:email_validator/email_validator.dart';
import 'package:formz/formz.dart';

import '../../core/constants/enums.dart';

class Email extends FormzInput<String, RulesValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  RulesValidationError? validator(String value) {
    if (value.isEmpty) {
      return RulesValidationError.empty;
    }
    return EmailValidator.validate(value) ? null : RulesValidationError.invalid;
  }
}
