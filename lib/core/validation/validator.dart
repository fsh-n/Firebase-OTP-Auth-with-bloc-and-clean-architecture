import 'package:formz/formz.dart';

enum ShortStringValidationError { invalid }
enum LongStringValidationError { invalid }
enum NumberValidationError { invalid }
enum EmailValidationError { invalid }
enum CostValidationError { invalid }

// Short string validator like name, username etc
class StringValidator extends FormzInput<String, ShortStringValidationError> {
  const StringValidator.pure() : super.pure('');
  const StringValidator.dirty([String value = '']) : super.dirty(value);

  @override
  ShortStringValidationError? validator(String value) {
    return (value.isNotEmpty == true && value.length > 3)
        ? null
        : ShortStringValidationError.invalid;
  }
}

// Long String validator like description
class LongStringValidator
    extends FormzInput<String, LongStringValidationError> {
  const LongStringValidator.pure() : super.pure('');
  const LongStringValidator.dirty([String value = '']) : super.dirty(value);

  @override
  LongStringValidationError? validator(String value) {
    return (value.isNotEmpty == true && value.length > 50)
        ? null
        : LongStringValidationError.invalid;
  }
}

// Email Validator
class EmailValidator extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const EmailValidator.pure() : super.pure('');

  /// {@macro email}
  const EmailValidator.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-10.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

// Number validator like pincode etc
class NumberValidator extends FormzInput<String, NumberValidationError> {
  const NumberValidator.pure() : super.pure('');
  const NumberValidator.dirty(String value) : super.dirty(value);

  @override
  NumberValidationError? validator(String value) {
    return int.tryParse(value) != null ? null : NumberValidationError.invalid;
  }
}

// Plan Cost validator
class CostValidator extends FormzInput<double, CostValidationError> {
  const CostValidator.pure() : super.pure(0.0);
  const CostValidator.dirty(double value) : super.dirty(value);

  @override
  CostValidationError? validator(double value) {
    return (value > 30.0) ? null : CostValidationError.invalid;
  }
}
