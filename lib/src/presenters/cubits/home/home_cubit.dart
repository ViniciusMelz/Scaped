import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/domain/repositories/i_post_dao.dart';

import '../../../config/router/app_router.dart';
import '../../../config/themes/app_theme.dart';
import '../../../domain/models/post.dart';
import '../../../domain/repositories/i_auth.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const LoadingHomeState()) {
    _getPosts();
  }

  void logOut() {
    Modular.get<IAuth>().signOut();
    Modular.to.navigate(appRouter.loginRoute);
  }

  void changeTheme() {
    Modular.get<AppTheme>().setTheme(
      Modular.get<AppTheme>().themeNotifier.value == ApplicationTheme.light ? ApplicationTheme.dark : ApplicationTheme.light,
    );
    emit(state);
  }

  Future<void> _getPosts() async {
    try {
      emit(const LoadingHomeState());
      List<Post> list = await Modular.get<IPostDAO>().getPosts();
      emit(LoadedHomeState(posts: list));
    } catch (e) {
      emit(ErrorHomeState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    _getPosts();
  }
}
