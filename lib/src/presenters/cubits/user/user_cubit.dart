import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/domain/models/user.dart';
import 'package:scaped/src/domain/repositories/i_user_dao.dart';
import 'package:scaped/src/presenters/cubits/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(DefaultUserState());

  User? user;

  void saveUser(String name, String lastName, String avatar) async {
    bool alterado = true;
    if (user == null) {
      user = User.empty();
      alterado = false;
    }
    user!.name = name;
    user!.lastName = lastName;
    user!.avatar = avatar;

    bool result;
    if (alterado) {
      result = await Modular.get<IUserDAO>().updateUser(user!);
    } else {
      result = await Modular.get<IUserDAO>().insertUser(user!);
    }
    emit(result ? SuccessUserState() : ErrorUserState('Deu algum erro, não tratei'));
  }

  Future<List<User>> loadUser() async {
    return Modular.get<IUserDAO>().getUsers();
  }
}
