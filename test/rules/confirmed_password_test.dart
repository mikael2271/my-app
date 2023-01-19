import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/core/constants/enums.dart';
import 'package:my_app/presentation/rules/confirmed_password.dart';

void main() {
  const passwordString = 'mock-password';
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const confirmedPassword = ConfirmedPassword.pure();
        expect(confirmedPassword.value, '');
        expect(confirmedPassword.pure, true);
      });

      test('dirty creates correct instance', () {
        const confirmedPassword = ConfirmedPassword.dirty(
          password: passwordString,
          value: passwordString,
        );
        expect(confirmedPassword.value, passwordString);
        expect(confirmedPassword.pure, false);
      });

      group('validator', () {
        test('returns empty error when password is empty', () {
          expect(
            const ConfirmedPassword.dirty(password: passwordString).error,
            RulesValidationError.empty,
          );
        });

        test('is invalid when the passwords does not match', () {
          expect(
            const ConfirmedPassword.dirty(
              password: passwordString,
              value: 'wrongMatch',
            ).error,
            RulesValidationError.invalid,
          );
        });

        test('is valid when the passwords matches', () {
          expect(
            const ConfirmedPassword.dirty(
              password: passwordString,
              value: passwordString,
            ).error,
            isNull,
          );
        });
      });
    });
  });
}
