class DataValidation {
  static String? requiredFieldValidation(String? value) {
    if (value!.isEmpty) return 'This is Required.';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? notNull(String? value) {
    if (value!.isEmpty) {
      return 'This is Required.';
    }
    return null;
  }

  static String? emailValidation(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Please enter a valid password.';
    }
    return null;
  }
}
