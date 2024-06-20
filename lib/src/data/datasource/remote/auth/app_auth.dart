import 'dart:async';
import 'dart:ui';

import 'package:scaped/src/data/datasource/remote/db.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppAuth {
  StreamSubscription<AuthState>? _authStateListener;

  AppAuth() {
    DB.init();
  }

  void signInMagicLink(String email) {
    Supabase.instance.client.auth.signInWithOtp(
      email: email,
      emailRedirectTo: 'com.ifsul.scaped://login-callback',
    );
  }

  bool isAuthenticated() {
    return Supabase.instance.client.auth.currentSession != null;
  }

  void signOut() {
    Supabase.instance.client.auth.signOut();
  }

  void checkAuthState({VoidCallback? onAuthenticated}) {
    _authStateListener = Supabase.instance.client.auth.onAuthStateChange.listen((ev) {
      if (ev.event == AuthChangeEvent.signedIn && onAuthenticated != null) {
        onAuthenticated.call();
        _authStateListener!.cancel();
      }
    });
  }

  void cancelAuthStateCheck() {
    _authStateListener?.cancel();
  }
}
