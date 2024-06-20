import 'package:flutter/widgets.dart';

abstract interface class IAuth {
  void signIn({required String email});
  bool isAuthenticaded();
  void signOut();
  void onAuthStateChange({VoidCallback? onAuthenticated});
  void cancelAuthCheck();
}
