import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/models/post.dart';
import '../../../domain/repositories/i_post_dao.dart';
import 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit() : super(const LoadingMyPostsState());

  Future<void> _getPosts() async {
    try {
      emit(const LoadingMyPostsState());
      List<Post> list = await Modular.get<IPostDAO>().getMyPosts();
      emit(LoadedMyPostsState(posts: list));
    } catch (e) {
      emit(ErrorMyPostsState(error: e.toString()));
    }
  }

  Future<void> refresh() async {
    _getPosts();
  }

  Future<void> delete(Post post) async {
    await Modular.get<IPostDAO>().deletePost(post);
    _getPosts();
  }
}
