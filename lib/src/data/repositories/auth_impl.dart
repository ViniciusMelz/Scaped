import 'package:flutter/widgets.dart';
import 'package:scaped/src/data/datasource/remote/auth/app_auth.dart';
import 'package:scaped/src/domain/repositories/i_auth.dart';

class AuthImpl implements IAuth {
  final AppAuth _appAuth;
  AuthImpl(this._appAuth);

  @override
  void signIn({required String email}) {
    return _appAuth.signInMagicLink(email);
  }

  @override
  bool isAuthenticaded() {
    return _appAuth.isAuthenticated();
  }

  @override
  void signOut() {
    return _appAuth.signOut();
  }

  @override
  void onAuthStateChange({VoidCallback? onAuthenticated}) {
    return _appAuth.checkAuthState(onAuthenticated: onAuthenticated);
  }

  @override
  void cancelAuthCheck() {
    return _appAuth.cancelAuthStateCheck();
  }
}
