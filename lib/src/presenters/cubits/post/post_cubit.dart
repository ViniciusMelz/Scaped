import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/domain/models/post.dart';
import 'package:scaped/src/domain/repositories/i_post_dao.dart';
import 'package:scaped/src/presenters/cubits/post/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final ScreenMode _screenMode = ScreenMode.insert;
  PostCubit() : super(DefaultPostState());

  Post? post;

  void savePost(String title, String issue) async {
    bool alterado = true;
    if (post == null) {
      post = Post.empty();
      alterado = false;
    }
    post!.title = title;
    post!.issue = issue;

    bool result;
    if (alterado) {
      result = await Modular.get<IPostDAO>().updatePost(post!);
    } else {
      result = await Modular.get<IPostDAO>().insertPost(post!);
    }
    emit(result ? SuccessPostState(_screenMode) : ErrorPostState('Deu algum erro, não tratei', _screenMode));
  }
}
