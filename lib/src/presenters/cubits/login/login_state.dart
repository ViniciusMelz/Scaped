sealed class LoginState {
  final String email;
  const LoginState({this.email = ''});
}

class FormLoginState extends LoginState {
  const FormLoginState();
}

class WaitingLoginState extends LoginState {
  const WaitingLoginState({super.email = ''});
}

class AuthenticatedLoginState extends LoginState {
  const AuthenticatedLoginState();
}
