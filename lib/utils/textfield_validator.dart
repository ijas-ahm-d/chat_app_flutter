import 'package:email_validator/email_validator.dart';

class Validator {
  static textfieldValidator(
      {String? value,
      required bool isUser,
      required bool isPassword,
      required bool isEmail}) {
    if (isUser) {
      if (value == null || value.isEmpty) {
        return "Username is required";
      }
    }

    if (isPassword) {
      if (value == null || value.isEmpty) {
        return "password is required";
      } else if (value.length < 8) {
        return "password must be 8 or more charecters";
      }
    }
    if (isEmail) {
      if (value == null || value.isEmpty) {
        return "Email is required";
      } else if (!EmailValidator.validate(value)) {
        return "Enter a valid Email";
      }
    }
  }
}
