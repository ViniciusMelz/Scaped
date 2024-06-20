class Validators {
  static final RegExp regexpEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool validateEmail(String? email) {
    if (email == null) {
      return false;
    }

    return regexpEmail.hasMatch(email.toLowerCase());
  }
}
