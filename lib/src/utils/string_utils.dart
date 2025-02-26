class StringUtils {
  static bool isNotNullAndEmpty(String? value) {
    return value != null && value.isNotEmpty && value != 'null';
  }

  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty || value == 'null';
  }

  static String getNonNullAndEmpty(String? value, {String defaultValue = '-'}) {
    return value == null || value.isEmpty || value == 'null'
        ? defaultValue
        : value;
  }

  static String removeTrailingZeros(String strNum) {
    return strNum.endsWith(".0")
        ? strNum.substring(0, strNum.length - 2)
        : strNum;
  }
}
