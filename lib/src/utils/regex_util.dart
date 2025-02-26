class RegexConstant {
  RegexConstant._();

  static const String email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String number = r"[\d]";
  static const String alphaNumeric = r'[a-zA-Z\d]';
  static const String double = r'(^\d*\.?\d*)';
}

class RegexUtil {
  RegexUtil._();

  static RegExp toRegex(String pattern) {
    return RegExp(pattern);
  }

  static bool isEmailValid(String email) {
    return toRegex(RegexConstant.email).hasMatch(email);
  }

  static bool isNumber(String value) {
    return toRegex(RegexConstant.number).hasMatch(value);
  }
}
