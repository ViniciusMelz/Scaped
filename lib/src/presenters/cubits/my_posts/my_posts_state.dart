import '../../../domain/models/post.dart';

sealed class MyPostsState {
  const MyPostsState();

  List<Post> get postList => const [];
  String get message => '';
}

class LoadingMyPostsState extends MyPostsState {
  const LoadingMyPostsState();
}

class LoadedMyPostsState extends MyPostsState {
  final List<Post> posts;
  const LoadedMyPostsState({this.posts = const []});

  @override
  List<Post> get postList => [...posts];
}

class ErrorMyPostsState extends MyPostsState {
  final String error;
  const ErrorMyPostsState({this.error = ''});

  @override
  String get message => error;
}
