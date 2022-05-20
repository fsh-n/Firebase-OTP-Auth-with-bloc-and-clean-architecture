import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum PhoneValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template phone no}
/// Form input for an phone no input.
/// {@endtemplate}
class PhoneNoValidator extends FormzInput<String, PhoneValidationError> {
  /// {@macro email}
  const PhoneNoValidator.pure() : super.pure('');

  /// {@macro email}
  const PhoneNoValidator.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
    r'(^(?:[+0]9)?[0-9]{9,11}$)',
  );

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}
