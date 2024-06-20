import '../../../domain/models/post.dart';

sealed class HomeState {
  const HomeState();

  List<Post> get postList => const [];
  String get message => '';
}

class LoadingHomeState extends HomeState {
  const LoadingHomeState();
}

class LoadedHomeState extends HomeState {
  final List<Post> posts;
  const LoadedHomeState({this.posts = const []});

  @override
  List<Post> get postList => [...posts];
}

class ErrorHomeState extends HomeState {
  final String error;
  const ErrorHomeState({this.error = ''});

  @override
  String get message => error;
}
