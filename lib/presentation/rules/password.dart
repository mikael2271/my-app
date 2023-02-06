import 'package:formz/formz.dart';

import '../../core/constants/enums.dart';

class Password extends FormzInput<String, RulesValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp =
      RegExp(r'^.*(?=.{3,})(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!$#%.,_?():;@]).*$');

  @override
  RulesValidationError? validator(String value) {
    if (value.isEmpty) {
      return RulesValidationError.empty;
    }
    return _passwordRegExp.hasMatch(value)
        ? null
        : RulesValidationError.invalid;
  }
}
