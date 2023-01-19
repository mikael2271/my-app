import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/core/constants/enums.dart';
import 'package:my_app/presentation/rules/email.dart';

void main() {
  const emailString = 'mock-email@teste.com';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const email = Email.pure();
        expect(email.value, '');
        expect(email.pure, true);
      });

      test('dirty creates correct instance', () {
        const email = Email.dirty(emailString);
        expect(email.value, emailString);
        expect(email.pure, false);
      });

      group('validator', () {
        test('returns empty error when email is empty', () {
          expect(
            const Email.dirty().error,
            RulesValidationError.empty,
          );
        });

        test('is invalid', () {
          expect(
            const Email.dirty('invalid-email').error,
            RulesValidationError.invalid,
          );
        });

        test('is valid when', () {
          expect(
            const Email.dirty(emailString).error,
            isNull,
          );
        });
      });
    });
  });
}
