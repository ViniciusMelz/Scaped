import '../../../domain/models/post.dart';

enum ScreenMode { insert, update }

sealed class PostState {
  Post? post;
  ScreenMode screenMode = ScreenMode.insert;
  PostState({this.post, required this.screenMode});
}

class DefaultPostState extends PostState {
  DefaultPostState({Post? post}) : super(post: post, screenMode: post == null ? ScreenMode.insert : ScreenMode.update);
}

class SuccessPostState extends PostState {
  SuccessPostState(ScreenMode screenMode) : super(screenMode: screenMode);
}

class ErrorPostState extends PostState {
  String error;
  ErrorPostState(this.error, ScreenMode screenMode) : super(screenMode: screenMode);
}
