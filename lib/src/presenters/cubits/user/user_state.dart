import '../../../domain/models/user.dart';

sealed class UserState {
  User? user;
  UserState({this.user});
}

class DefaultUserState extends UserState {
  DefaultUserState({User? post}) : super(user: post);
}

class SuccessUserState extends UserState {
  SuccessUserState();
}

class ErrorUserState extends UserState {
  String error;
  ErrorUserState(this.error);
}
