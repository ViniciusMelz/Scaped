import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaped/src/domain/models/post.dart';
import 'package:scaped/src/presenters/pages/post_details_page/post_details_page.dart';
import 'package:scaped/src/presenters/pages/user_page/user_page.dart';

import '../../../splash_page.dart';
import '../../presenters/pages/home_page/home_page.dart';
import '../../presenters/pages/login_page/login_page.dart';
import '../../presenters/pages/my_posts_page/my_posts_page.dart';
import '../../presenters/pages/post_page/post_page.dart';

final appRouter = AppRouter._();

class AppRouter {
  AppRouter._();

  final String loginRoute = '/login';
  final String homeRoute = '/home';
  final String postDetailsRoute = '/postDetails';
  final String postRoute = '/post';
  final String myPostsRoute = '/myPosts';
  final String userRoute = '/user';

  static const TransitionType appDefaultTransition = TransitionType.fadeIn;
  static const Duration appDefaultTransitionDuration = Duration(milliseconds: 800);

  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SplashPage(),
        ),
        ChildRoute(
          loginRoute,
          child: (context, args) => const LoginPage(),
          duration: appDefaultTransitionDuration,
          transition: appDefaultTransition,
        ),
        ChildRoute(
          homeRoute,
          child: (context, args) => const HomePage(),
          duration: appDefaultTransitionDuration,
          transition: appDefaultTransition,
        ),
        ChildRoute(
          myPostsRoute,
          child: (context, args) => const MyPostsPage(),
          duration: appDefaultTransitionDuration,
          transition: appDefaultTransition,
        ),
        ChildRoute(
          postDetailsRoute,
          child: (context, args) => PostDetailsPage(post: args.data as Post),
          transition: appDefaultTransition,
        ),
        ChildRoute(
          postRoute,
          child: (context, args) => PostPage(post: args.data),
          transition: appDefaultTransition,
        ),
        ChildRoute(
          userRoute,
          child: (context, args) => UserPage(user: args.data),
          transition: appDefaultTransition,
        ),
      ];
}
