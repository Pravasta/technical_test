class Validator {
  static final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]{3,50}$');
  static final RegExp emailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  static final RegExp passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');

  static bool isValidName(String name) {
    return nameRegExp.hasMatch(name);
  }

  static bool isValidEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return passwordRegExp.hasMatch(password);
  }

  static bool arePasswordsMatching(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
