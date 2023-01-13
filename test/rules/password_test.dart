import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/core/constants/enums.dart';
import 'package:my_app/presentation/rules/password.dart';

void main() {
  const passwordString = 'mock-password';
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', (() {
        const password = Password.pure();
        expect(password.value, '');
        expect(password.pure, true);
      }));

      test('dirty creates correct instance', () {
        const password = Password.dirty(passwordString);
        expect(password.value, passwordString);
        expect(password.pure, false);
      });

      group('validator', () {
        test('returns empty error when password is empty', () {
          expect(
            const Password.dirty().error,
            RulesValidationError.empty,
          );
        });

        test('is invalid when password not fill every requirement', () {
          expect(
            const Password.dirty(passwordString).error,
            RulesValidationError.invalid,
          );
        });

        test('is valid when fill every requirement', () {
          expect(
            const Password.dirty(passwordString + "123!").error,
            isNull,
          );
        });
      });
    });
  });
}
